# syntax=docker/dockerfile:1
# check=error=true

# This Dockerfile supports both development (with Skaffold) and production (with Kamal).
# For dev: docker build -t rewardmanager . && skaffold dev
# For prod: docker build -t rewardmanager . && docker run -d -p 80:80 -e RAILS_MASTER_KEY=<value> rewardmanager

ARG RUBY_VERSION=3.3.0
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Rails app lives here
WORKDIR /rails

# Install base packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl default-mysql-client libjemalloc2 libvips && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Default to production environment, override in dev with Skaffold/Kubernetes env vars
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

# Throw-away build stage to reduce size of final image
FROM base AS build

# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential default-libmysqlclient-dev git libyaml-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Final stage for app image
FROM base

# Copy built artifacts: gems, application
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Create and own runtime and sync directories as a non-root user
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    mkdir -p app lib db log storage tmp && \
    chown -R rails:rails app lib db log storage tmp

# Run as non-root user
USER 1000:1000

# Entrypoint prepares the database (for production)
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start server (override CMD in dev with Skaffold/Kubernetes)
EXPOSE 80
CMD ["./bin/thrust", "./bin/rails", "server"]