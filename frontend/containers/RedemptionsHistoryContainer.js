'use client';

import { connect } from 'react-redux';
import { useRouterSync } from '@/hooks/useRouterSync';
import { redeemReward } from '@/reducers/rewards';
import { signOutUser } from '@/reducers/auth';
import { userSelector } from '@/selectors';

function RedemptionsHistoryContainer({ user, redemptions, loading, error }) {
  const { navigate } = useRouterSync();

  const navigateToDashboard = () => {
    navigate('/dashboard');
  }

  const navigateToHistory = (e) => {
    e.preventDefault();
    return false;
  }

  const signOutUser = () => {
    signOutUser();
    navigate('/auth');
  }

  return (
    <div style={{ display: 'grid', gridTemplateColumns: '50% 50%', gap: '20px', padding: '20px' }}>
      <div>
        <h1 style={{ margin: 0 }}>Welcome, {user?.email}</h1>
        <p style={{ fontSize: '14px', color: '#666' }}>
          Points Balance:
          {user?.points_balance} points
        </p>
      </div>
      <div style={{ textAlign: 'right' }}>
        <button
          style={{
            padding: '10px 20px',
            borderRadius: '8px',
            border: '1px solid #ccc',
            background: '#f0f0f0',
            cursor: 'pointer',
            marginRight: '10px',
          }}
          onClick={navigateToDashboard}
        >
          All Rewards
        </button>
        <button
          style={{
            padding: '10px 20px',
            borderRadius: '8px',
            border: '1px solid #ccc',
            background: '#f0f0f0',
            cursor: 'pointer',
            marginRight: '10px',
          }}
          onClick={navigateToHistory}
        >
          {user?.redemptions_count} Redemption(s)
        </button>
        <button
          style={{
            padding: '10px 20px',
            borderRadius: '8px',
            border: '1px solid #ccc',
            background: '#f0f0f0',
            cursor: 'pointer',
            marginRight: '10px',
          }}
          onClick={signOutUser}
        >
          Sign out
        </button>
      </div>
      <div>
        <h1 style={{ margin: 0 }}>Redemption History</h1>
        <p style={{ fontSize: '14px', color: '#666' }}>
          Your redeemed your points {user?.redemptions_count} time(s):
        </p>
      </div>
      <div style={{ gridColumn: '1 / 3' }}>
        {loading && <p>Loading...</p>}
        {error && <p>Error: {error}</p>}
        <ul style={{ listStyle: 'none', padding: 0 }}>
          {redemptions?.map((redemption) => (
            <li
              key={redemption.id}
              style={{
                border: '1px solid #ddd',
                borderRadius: '8px',
                padding: '10px',
                marginBottom: '10px',
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'center',
              }}
            >
              <span>
                {redemption.reward.name} - Redeemed on {new Date(redemption.created_at).toLocaleDateString()}
              </span>
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}

const mapStateToProps = (state) => ({
  user: userSelector(state),
  redemptions: state.redemptions.redemptions, // Assuming redemptions are in rewards slice
  loading: state.rewards.loading,
  error: state.rewards.error,
});

export default connect(mapStateToProps)(RedemptionsHistoryContainer);