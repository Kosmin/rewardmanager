import { configureStore } from '@reduxjs/toolkit';
import authReducer from '@/reducers/auth/index';

export const store = configureStore({
  reducer: {
    auth: authReducer,
  },
});

export default store;
