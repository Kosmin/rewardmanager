'use client';

import { connect } from 'react-redux';
import { useRouter } from 'next/navigation';
import { useEffect } from 'react';
import { Box, Button, Typography } from '@mui/material';
import { signOutUser } from '@/reducers/auth/index';
import { userSelector } from '@/selectors/index';

function DashboardContainer({ user, signOut }) {
  const router = useRouter();

  useEffect(() => {
    if (!user) router.push('/auth');
  }, [user, router]);

  return (
    <Box sx={{ display: 'flex', flexDirection: 'column', alignItems: 'center', mt: 8 }}>
      <Typography variant="h4">Welcome, {user?.email || 'User'}</Typography>
      <Button
        variant="contained"
        sx={{ mt: 2 }}
        onClick={signOut}
      >
        Sign Out
      </Button>
    </Box>
  );
}

const mapStateToProps = (state) => ({
  user: userSelector(state),
});

const mapDispatchToProps = (dispatch) => ({
  signOut: () => dispatch(signOutUser()),
});

export default connect(mapStateToProps, mapDispatchToProps)(DashboardContainer);
