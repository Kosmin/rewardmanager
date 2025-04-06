'use client';

import { connect } from 'react-redux';
import { useRouterSync } from '@/hooks/useRouterSync';
import { redeemReward } from '@/reducers/rewards';
import { signOutUser } from '@/reducers/auth';
import { userSelector } from '@/selectors';

function DashboardContainer({ user, rewards, loading, error, signOut, redeem }) {
  const { navigate } = useRouterSync();

  const handleRedeem = (rewardId) => {
    redeem(rewardId);
  };

  const navigateToDashboard = (e) => {
    e.preventDefault();
    return false;
  }

  const navigateToHistory = () => {
    navigate('/history');
  }

  const handleSignOut = () => {
    signOut();
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
          onClick={handleSignOut}
        >
          Sign out
        </button>
      </div>
      <div style={{ gridColumn: '1 / 3' }}>
        {loading && <p>Loading...</p>}
        {error && <p>Error: {error}</p>}
        <ul style={{ listStyle: 'none', padding: 0 }}>
          {rewards.map((reward) => (
            <li
              key={reward.id}
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
              <p>
                <span>{reward.name}</span><br/>
                <span style={{ fontSize: '14px', color: '#666' }}>{reward.description}</span>
              </p>
              <p>
                <button
                  style={{
                    padding: '5px 10px',
                    borderRadius: '4px',
                    border: '1px solid #ccc',
                    background: '#e0e0e0',
                    cursor: 'pointer',
                  }}
                  onClick={() => handleRedeem(reward.id)}
                >
                  Redeem
                </button><br/>
                <span style={{ fontSize: '14px', color: '#666' }}>
                  {reward.price} points
                </span>
              </p>
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}

const mapStateToProps = (state) => ({
  user: userSelector(state),
  rewards: state.rewards.rewards,
  loading: state.rewards.loading,
  error: state.rewards.error,
});

const mapDispatchToProps = {
  redeem: redeemReward,
  signOut: signOutUser,
};

export default connect(mapStateToProps, mapDispatchToProps)(DashboardContainer);