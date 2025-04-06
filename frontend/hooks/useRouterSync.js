'use client';

import { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useRouter, usePathname } from 'next/navigation';
import { fetchRewardsRequest } from '@/reducers/rewards';
import { fetchRedemptionsRequest } from '@/reducers/redemptions';
import { setToken, getUser } from '@/reducers/auth';
import { navigateTo } from '@/reducers/router';
import { current } from '@reduxjs/toolkit';

export const useRouterSync = () => {
  const dispatch = useDispatch();
  const router = useRouter();
  const pathName = usePathname();
  const currentPath = useSelector((state) => state.router.currentPath);
  const token = useSelector((state) => state.auth.token);

  const navigate = (path) => {
    router.push(path);
    dispatch(navigateTo(path));
  };

  useEffect(() => {
    const storedToken = localStorage.getItem('jwt_token');
    if (storedToken && !token) {
      dispatch(setToken(storedToken));
      dispatch(getUser());
      if (currentPath == '/auth' || currentPath == '/') {
        router.push('/dashboard');
        dispatch(navigateTo('/dashboard'));
        return;
      }
    }

    if (!token && !storedToken && currentPath !== '/auth') {
      router.push('/auth');
      return;
    } else if (token && currentPath === '/auth') {
      router.push('/dashboard');
      return
    }

    if (token){
      if (currentPath === '/dashboard') {
        dispatch(fetchRewardsRequest());
      } else if (currentPath == '/history') {
        dispatch(fetchRedemptionsRequest());
      }
    }
    if (pathName !== currentPath) {
      dispatch(navigateTo(pathName));
    }
  }, [pathName, currentPath, dispatch, token]);

  return { navigate, currentPath };
};
