'use client';

import { connect } from 'react-redux';
import { useEffect } from 'react';
import { useRouterSync } from '@/hooks/useRouterSync';
import Container from '@mui/material/Container';
import { Box, TextField, Button, Typography } from '@mui/material';
import { signUpUser, signInUser } from '@/reducers/auth/index';
import { emailSelector, passwordSelector, statusSelector, errorSelector, userSelector } from '@/selectors/index';


function AuthContainer({
  email, password, status, error, user, updateEmail, updatePassword, signUp, signIn
}) {
  const { navigate } = useRouterSync();
  useEffect(() => {
    if (user && user.status == 'succeeded') navigate('/dashboard');
  }, [user]);

  return (
    <Container maxWidth="xs">
      <Box sx={{ marginTop: 8, display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
        <Typography component="h1" variant="h5">
          Welcome
        </Typography>
        <Box component="form" sx={{ mt: 1 }}>
          <TextField
            margin="normal"
            required
            fullWidth
            id="email"
            label="Email Address"
            name="email"
            autoComplete="email"
            autoFocus
            value={email}
            onChange={(e) => updateEmail(e.target.value)}
          />
          <TextField
            margin="normal"
            required
            fullWidth
            name="password"
            label="Password"
            type="password"
            id="password"
            autoComplete="current-password"
            value={password}
            onChange={(e) => updatePassword(e.target.value)}
          />
          <Button
            type="submit"
            fullWidth
            variant="contained"
            sx={{ mt: 3, mb: 2 }}
            onClick={(e) => signIn(e, email, password)}
          >
            Sign In
          </Button>
          <Button
            type="submit"
            fullWidth
            variant="outlined"
            sx={{ mb: 2 }}
            onClick={(e) => signUp(e, email, password)}
          >
            Sign Up
          </Button>
          {status === 'loading' && <Typography>Processing...</Typography>}
          {status === 'failed' && <Typography color="error">{error}</Typography>}
        </Box>
      </Box>
    </Container>
  );
}

const mapStateToProps = (state) => ({
  email: emailSelector(state),
  password: passwordSelector(state),
  status: statusSelector(state),
  error: errorSelector(state),
  user: userSelector(state),
});

const mapDispatchToProps = (dispatch) => ({
  updateEmail: (email) => dispatch({ type: 'auth/updateEmail', payload: email }),
  updatePassword: (password) => dispatch({ type: 'auth/updatePassword', payload: password }),
  signUp: (e, email, password) => {
    e.preventDefault();
    dispatch(signUpUser({ email, password }));
  },
  signIn: (e, email, password) => {
    e.preventDefault();
    dispatch(signInUser({ email, password }));
  },
});

export default connect(mapStateToProps, mapDispatchToProps)(AuthContainer);
