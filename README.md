# README - RewardManager

## Requirements:
RESTful endpoints for the following:
- Retrieve a user’s current points balance
- Get a list of available rewards
- Allow users to redeem a reward
- Retrieve a user’s redemption history

## Bonus Features:
_given the extra time I was told others may be using, I decided to spice up my solution a little bit. Hopefully it's not an issue_

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
    - I assumed user only allowed to redeem each reward once, which means if the user attempts to redeem the same reward in multiple windows/threads, it could result in multiple redemptions for the same reward.

## Partial Local Setup
_use this if you have a running mysql instance_

1. Install ruby 3.3.0 via rbenv:`rbenv install 3.3.0` or rvm: `rvm install 3.3.0`
2. install gem: `bundle install`
3. create mysql user on your mysql instance, with username: `root` and password: `password` which has permissions to create a DB
4. setup the db: `bin/rails db:setup`
5. run the api/back-end server: `./bin/rails server start &`
6. run the front-end: `cd frontend && npm install && npm run dev &`
7. open [http://localhost:4000/auth](http://localhost:4000/auth) to view the app

## Skaffold Setup
_used to allow running the db, the back-end and the front-end via minikube, in one command_

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
6. open [http://localhost:4000](http://localhost:4000/auth) to view the app

## Limitations
- front-end code is not build with feature-first or functionality-first folders, could use some cleaning up
- UI has minimal error handling, no spinners for loading experience, etc.
- UI also uses some inefficient approaches, such as anonymous functions in render(), no immutable state, routing that results in flickering, etc. Did this on purpose to save a bit of time.
- back-end controllers use a few `Not Implemented` actions to demonstrate we could build them later, but they're not needed now
- admin work (i.e. `user create/update/delete`, `reward create/update/delete`, `redemption create/update/delete`) is only possible via rails console or graphiql interface
- realtime file sync updates in skaffold are not always working as expected
- I thought it'd be cool to have counter_cache columns for how many users claimed a specific reward, and demonstrate how these counters could all be updated in batches with throttling. Didn't have time to finish that, but left the column in
- I also thought it'd be cool to have expiry on rewards, and run a background job using either solid queue or sidekiq w/ redis based on a cron schedule to expire rewards. I also decided this is probably beyond the scope, but still kept the `expires_at` column on the `rewards` table

# DEMO

## UI interface


https://github.com/user-attachments/assets/14dcfd54-6f8f-46a6-9930-245a7d723dc4


## GraphiQL Admin Interface



https://github.com/user-attachments/assets/14583313-6528-4648-af45-3ab75d192546

