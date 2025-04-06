// frontend/selectors/auth/index.js
export const emailSelector = (state) => state.auth.email;
export const passwordSelector = (state) => state.auth.password;
export const statusSelector = (state) => state.auth.status;
export const errorSelector = (state) => state.auth.error;
export const userSelector = (state) => state.auth.user;
export const routeSelector = (state) => state.router.currentPath;
export const rewardsSelector = (state) => state.rewards;
export const tokenSelector = (state) => state.auth.token;
