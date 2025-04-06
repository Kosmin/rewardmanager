import { createSlice } from '@reduxjs/toolkit';

const redemptionsSlice = createSlice({
  name: 'redemptions',
  initialState: {
    redemptions: [],
    loading: false,
    error: null,
  },
  reducers: {
    fetchRedemptionsRequest(state) {
      state.loading = true;
    },
    fetchRedemptionsSuccess(state, action) {
      state.redemptions = action.payload;
      state.loading = false;
    },
    fetchRedemptionsFailure(state, action) {
      state.error = action.payload;
      state.loading = false;
    },
  },
});

export const {
  fetchRedemptionsRequest,
  fetchRedemptionsSuccess,
  fetchRedemptionsFailure,
} = redemptionsSlice.actions;

export default redemptionsSlice.reducer;
