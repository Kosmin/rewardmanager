// frontend/reducers/auth/index.js
import { createAction, createReducer } from '@reduxjs/toolkit';

export const signUpUser = createAction('auth/signUpUser');
export const signInUser = createAction('auth/signInUser');
export const signOutUser = createAction('auth/signOutUser');
export const signUpSuccess = createAction('auth/signUpSuccess');
export const signUpFailure = createAction('auth/signUpFailure');
export const signInSuccess = createAction('auth/signInSuccess');
export const signInFailure = createAction('auth/signInFailure');
export const signOutSuccess = createAction('auth/signOutSuccess');
export const getUser = createAction('auth/getUser');
export const setUser = createAction('auth/setUser');
export const setToken = createAction('auth/setToken');
export const clearToken = createAction('auth/clearToken');

const initialState = {
  email: '',
  password: '',
  user: null,
  token: null,
  status: 'idle',
  error: null,
};

const authReducer = createReducer(initialState, (builder) => {
  builder
    .addCase(signUpUser, (state) => { state.status = 'loading'; state.error = null; })
    .addCase(signInUser, (state) => { state.status = 'loading'; state.error = null; })
    .addCase(getUser, (state) => { state.status = 'loading'; state.error = null; })
    .addCase(signOutUser, (state) => { state.status = 'loading'; state.error = null; })
    .addCase(setUser, (state, action) => {
      state.email = action.payload.email;
      state.user = action.payload;
      state.status = 'succeeded';
      state.error = null;
    })
    .addCase(signUpSuccess, (state, action) => {
      state.status = 'succeeded';
      state.user = action.payload.user;
      state.token = action.payload.token;
      state.error = null;
    })
    .addCase(signInSuccess, (state, action) => {
      state.status = 'succeeded';
      state.user = action.payload.user;
      state.token = action.payload.token;
      state.error = null;
    })
    .addCase(signOutSuccess, (state) => {
      state.user = null;
      state.token = null;
      state.status = 'idle';
      state.error = null;
    })
    .addCase(signUpFailure, (state, action) => { state.status = 'failed'; state.error = action.payload; })
    .addCase(signInFailure, (state, action) => { state.status = 'failed'; state.error = action.payload; })
    .addCase('auth/updateEmail', (state, action) => { state.email = action.payload; })
    .addCase('auth/updatePassword', (state, action) => { state.password = action.payload; })
    .addCase(setToken, (state, action) => { state.token = action.payload; })
    .addCase(clearToken, (state) => { state.token = null; });
});

export default authReducer;