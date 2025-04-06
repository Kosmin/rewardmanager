import { createSlice } from '@reduxjs/toolkit';

const rewardsSlice = createSlice({
  name: 'rewards',
  initialState: {
    rewards: [],
    loading: false,
    error: null,
  },
  reducers: {
    fetchRewardsRequest(state) {
      state.loading = true;
    },
    fetchRewardsSuccess(state, action) {
      state.rewards = action.payload;
      state.loading = false;
    },
    fetchRewardsFailure(state, action) {
      state.error = action.payload;
      state.loading = false;
    },
    redeemReward() {},
  },
});

export const { fetchRewardsRequest, fetchRewardsSuccess, fetchRewardsFailure, redeemReward } = rewardsSlice.actions;
export default rewardsSlice.reducer;