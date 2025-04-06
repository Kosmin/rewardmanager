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
    .addCase(signOutUser, (state) => { state.status = 'loading'; state.error = null; })
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
    .addCase('auth/updatePassword', (state, action) => { state.password = action.payload; });
});

export default authReducer;