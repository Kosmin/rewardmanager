# README - RewardManager

## Full Local Setup
_used to allow running both back-end and front-end via minikube_

1. Ensure you have installed
    * minikube
    * skaffold
    * virtualbox
    * ruby 3.3.0
    * bundler gem, via `gem install bundler`
3. Run `skaffold dev`
4. open http://localhost:3000

## Partial Local Setup
_used without kubernetes (k8s) or minikube overhead_

1. Install ruby 3.3.0 via rbenv:`rbenv install 3.3.0` or rvm: `rvm install 3.3.0`
2. install gem: `bundle install`
3. setup the db: `bin/rails db:setup`
4. run the api/back-end server: `bin/rails server start`
5. run the front-end: `cd frontend && npm run dev`


## Architecture & Rationale
* Separate API back-end and NextJS front-end, with the frontend put under `./frontend`
    * this allows the back-end to skip unnecessary middleware
    * allows front-end to easily leverage open-source packages such as storybook without additional configuration (i.e. `react_on_rails` or `react-rails` don't allow this as easily)
    * Allows scaling to different front-ends, not just for web but maybe for a mobile app with React.Native or a web3 decentralized app (DAPP) while still not requiring running into rails overhead
* GraphQL
    * Avoids manual JSON parsing on the front-end
    * more flexibility when updating resources or endpoints, and fewer changes required
