import { createSlice } from '@reduxjs/toolkit';

const routerSlice = createSlice({
  name: 'router',
  initialState: {
    currentPath: '/',
  },
  reducers: {
    navigateTo: (state, action) => {
      state.currentPath = action.payload;
    },
  },
});

export const { navigateTo } = routerSlice.actions;
export default routerSlice.reducer;
