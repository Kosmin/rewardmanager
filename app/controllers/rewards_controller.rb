class RewardsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    # Fetch all rewards, including the number of redemptions and users
    @rewards = Reward.includes(:redemptions).order(created_at: :desc)
    render json: RewardSerializer.new(@rewards).serializable_hash
  end

  def create
    # Not implemented - in the interest of time, creation is done via the graphql admin or rails console
    render json: { message: "Not implemented" }, status: :not_implemented
  end

  def show
    # Not implemented - rewards should be visible via index only for now
    render json: { message: "Not implemented" }, status: :not_implemented
  end

  def update
    # Not implemented - in the interest of time, updates are done via the graphql admin or rails console
    render json: { message: "Not implemented" }, status: :not_implemented
  end

  def destroy
    # Not implemented - in the interest of time, deletions are done via the graphql admin or rails console
    render json: { message: "Not implemented" }, status: :not_implemented
  end
end
