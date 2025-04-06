# README - RewardManager

## Full Local Setup
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
5. Inside project root folder, Run `skaffold dev`
6. open [http://localhost:3000](http://localhost:3000)

## Partial Local Setup
_used without kubernetes (k8s) or minikube overhead_

1. Install ruby 3.3.0 via rbenv:`rbenv install 3.3.0` or rvm: `rvm install 3.3.0`
2. install gem: `bundle install`
3. setup the db: `bin/rails db:setup`
4. run the api/back-end server: `bin/rails server start`
5. run the front-end: `cd frontend && npm install && npm run dev`
6. access graphql endpoints to add/remove rewards: [http://localhost:3000/graphiql]


## Highlights - Tools
1. **Ruby on Rails API** - back-end
2. **Devise & Devise-JWT Auth** on the back-end, using JWT for increased security
3. **REST-ful endpoints for API**
4. **GraphQL API** - as an **alternative** API for rails back-end, using `graphql` gem
5. **NextJS Front-end**
6. React, React Redux, Redux Sagas & Redux Routing in NextJS for **UI**
7. **TailwindCSS, MaterialUI, emotion** - for front-end css-in-js
8. **Apollo Studio** - for front-end API
9. **Docker, Kubernetes & Skaffold** - for local development using realtime updates and production-like containers
10. **Rspec** for back-end testing
11. **Front-end testing ommitted** due to time constraints

## Highlights - Architecture
1. indexes on all DB tables to ensure data integrity
2. validations on ActiveRecord models to help with error messages and additional data integrity
3. addressed 2 concurrency issues:

    1. User Redeems the same reward multiple times - could result in the same user redeeming the same reward more than once
    2. User redeems multiple rewards to bypass 0 balance - concurrency issues could result in a user attempting to redeem multiple rewards really fast with a low balance, tricking the back-end into redeeming beyond 0 balance
