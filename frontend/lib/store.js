// lib/store.js
import { configureStore } from '@reduxjs/toolkit';
import createSagaMiddleware from 'redux-saga';
import authReducer from '@/reducers/auth/index';
import rootSaga from '@/sagas/index';
import routerReducer from '@/reducers/router';
import rewardsReducer from '@/reducers/rewards';
import redemptionsReducer from '@/reducers/redemptions';

const sagaMiddleware = createSagaMiddleware();

export const store = configureStore({
  reducer: {
    auth: authReducer,
    router: routerReducer,
    rewards: rewardsReducer,
    redemptions: redemptionsReducer,
  },
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware({ thunk: false }).concat(sagaMiddleware),
});

sagaMiddleware.run(rootSaga);