// TODO: split in separate folders

import { takeLatest, call, put, select } from 'redux-saga/effects';
import { fetchRewardsRequest, fetchRewardsSuccess, fetchRewardsFailure } from '@/reducers/rewards';
import { fetchRedemptionsRequest, fetchRedemptionsSuccess, fetchRedemptionsFailure } from '@/reducers/redemptions';
import { getUser, signUpUser, signInUser, signOutUser, signUpSuccess, signUpFailure, signInSuccess, signInFailure, signOutSuccess, setUser } from '@/reducers/auth';
import { tokenSelector } from '@/selectors';
import { navigateTo } from '@/reducers/router';

function* getUserSaga(action) {
  try {
    const token = yield select(tokenSelector);
    const response = yield call(fetch, 'http://localhost:3000/users/info', {
      method: 'GET',
      headers: {
        Authorization: `Bearer ${token}`,
        'Content-Type': 'application/json',
      },
    });
    if (!response.ok) throw new Error('Could not retrieve user');
    const data = yield response.json();
    yield put(setUser(data.data.attributes));
  } catch (error) {
    yield put(signOutSuccess());
    console.error('Error:', error.message);
  }
}

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
    localStorage.setItem('jwt_token', data.token);
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
    localStorage.setItem('jwt_token', data.token);
    yield put(signInSuccess({ user: data.user, token: data.token }));
    yield put(navigateTo('/dashboard'));

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
    localStorage.removeItem('jwt_token');
    yield put(signOutSuccess());
    yield put(navigateTo('/auth'));
  } catch (error) {
    yield put(signInFailure(error.message)); // Reuse failure for simplicity
  }
}

function* fetchRewardsSaga() {
  try {
    const token = yield select(tokenSelector);
    const response = yield call(fetch, 'http://localhost:3000/rewards', {
      headers: {
        Authorization: `Bearer ${token}`,
        'Content-Type': 'application/json',
      },
    });
    const data = yield response.json();
    const rewards = data.rewards.data.map(item => item.attributes);
    yield put(fetchRewardsSuccess(rewards));
  } catch (error) {
    yield put(fetchRewardsFailure(error.message));
  }
}

function* redeemRewardSaga(action) {
  try {
    const token = yield select(tokenSelector);
    const response = yield call(fetch, 'http://localhost:3000/redemptions', {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${token}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ reward_id: action.payload }),
    });
    if (!response.ok) throw new Error('Redemption failed');
    const data = yield response.json();
    yield call(fetchRewardsSaga);
    yield call(getUserSaga);
  } catch (error) {
    console.error('Redeem error:', error.message);
  }
}

function* fetchRedemptionsSaga() {
  try {
    const token = yield select(tokenSelector);
    const response = yield call(fetch, 'http://localhost:3000/redemptions', {
      headers: { Authorization: `Bearer ${token}` },
      credentials: 'include',
    });
    const data = yield response.json();
    const redemptions = data.data.map(item => ({
      id: item.attributes.id,
      reward: item.attributes.reward,
      created_at: item.attributes.created_at,
    }));
    yield put(fetchRedemptionsSuccess(redemptions));
  } catch (error) {
    yield put(fetchRedemptionsFailure(error.message));
  }
}

export default function* rootSaga() {
  yield takeLatest(signUpUser.type, signUpSaga);
  yield takeLatest(signInUser.type, signInSaga);
  yield takeLatest(signOutUser.type, signOutSaga);
  yield takeLatest(fetchRewardsRequest.type, fetchRewardsSaga);
  yield takeLatest('rewards/redeemReward', redeemRewardSaga);
  yield takeLatest(getUser.type, getUserSaga);
  yield takeLatest(fetchRedemptionsRequest.type, fetchRedemptionsSaga);
}
