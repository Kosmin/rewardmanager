# README - RewardManager

## Assignment Requirements:
Implement RESTful endpoints for the following:
- Retrieve a user’s current points balance
- Get a list of available rewards
- Allow users to redeem a reward
- Retrieve a user’s redemption history

## Bonus Features:
_given the extra time, I decided to spice up my solution a little bit. Hopefully it's not an issue_

- UI (fully functioning) - using `NextJS`, `React`, `Redux`, `Redux Sagas`, `Redux & NextJS Routing`
- Orchestration - using `Docker`, `Kubernetes` and `Skaffold` (for local dev)
- User Auth (sign-in, sign-up and sign out) - using `Devise` and `Devise-JWT`
- Persistent front-end User Auth - via `localstorage` caching of the user's JWT token
- GraphiQL Admin - implemented a GraphQL API and used GraphiQL to allow UI Admin operations (such as creating rewards, users, etc)
- `counter-cache` columns for users' redemptions' count, and for rewards' redemptions' count.
- RSpec tests for the back-end models, controllers & serializers
- DB indexes & model validations for data integrity
- Concurrency protection (via db unique indexes, db transactions & pessimistic row locking):
    - User attempts to redeem multiple rewards with insufficient balance; multi-threaded puma might result in a negative DB balance due to context switches
    - Assumed user only allowed to redeem each reward once - If user attempts to redeem the same productin multiple windows/threads, it could result in multiple redemptions for the same reward.

## Partial Local Setup
_use this if you have a running mysql instance_

1. Install ruby 3.3.0 via rbenv:`rbenv install 3.3.0` or rvm: `rvm install 3.3.0`
2. install gem: `bundle install`
3. create mysql user on your mysql instance, with username: `root` and password: `password` which has permissions to create a DB
4. setup the db: `bin/rails db:setup`
5. run the api/back-end server: `./bin/rails server start &`
6. run the front-end: `cd frontend && npm install && npm run dev &`
7. open [http://localhost:4000](http://localhost:4000) to view the app

## Skaffold Setup
_used to allow running both back-end and front-end via minikube_

1. Ensure you have installed
    * [colima](https://github.com/abiosoft/colima)
    * minikube
    * skaffold
    * ruby 3.3.0
    * bundler gem, via `gem install bundler`
2. `colima start --cpu 2 --memory 5`
3. `minikube start --driver=docker --memory=4800 --cpus=2`
4. `brew install skaffold`
5. run `bundle install` as skaffold relies on cached artifacts so it'll use the locally installed gems
5. Inside project root folder, Run `skaffold dev`
6. open [http://localhost:4000](http://localhost:4000) to view the app
7. open [http://localhost:3000/graphiql](http://localhost:4000)
