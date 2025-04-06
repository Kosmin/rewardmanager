// TODO: split in separate folders

import { takeLatest, call, put } from 'redux-saga/effects';
import { signUpUser, signInUser, signOutUser, signUpSuccess, signUpFailure, signInSuccess, signInFailure } from '@/reducers/auth/index';

function* signUpSaga(action) {
  try {
    const response = yield call(
      fetch,
      'http://localhost:3000/users',
      {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ user: { email: action.payload.email, password: action.payload.password } }),
        credentials: 'include',
      }
    );
    const data = yield response.json();
    if (!response.ok) {
      throw new Error(data.errors ? data.errors.join(', ') : 'Sign up failed');
    }
    yield put(signUpSuccess({ user: data.user, token: data.token }));
  } catch (error) {
    yield put(signUpFailure(error.message));
  }
}

function* signInSaga(action) {
  try {
    const response = yield call(
      fetch,
      'http://localhost:3000/users/sign_in',
      {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          user: { email: action.payload.email, password: action.payload.password }
        }),
        credentials: 'include',
      }
    );
    const data = yield response.json();
    if (!response.ok) {
      throw new Error(data.errors ? data.errors.join(', ') : 'Sign in failed');
    }
    yield put(signInSuccess({ user: data.user, token: data.token }));
  } catch (error) {
    yield put(signInFailure(error.message));
  }
}

function* signOutSaga() {
  try {
    const response = yield call(fetch, 'http://localhost:3000/users/sign_out', {
      method: 'DELETE',
      credentials: 'include',
    });
    if (!response.ok) throw new Error('Sign out failed');
    yield put(signOutSuccess());
  } catch (error) {
    yield put(signInFailure(error.message)); // Reuse failure for simplicity
  }
}

export default function* rootSaga() {
  yield takeLatest(signUpUser.type, signUpSaga);
  yield takeLatest(signInUser.type, signInSaga);
  yield takeLatest(signOutUser.type, signOutSaga);
}