'use client';

import { CacheProvider } from '@emotion/react';
import createCache from '@emotion/cache';
import { Provider } from 'react-redux';
import { store } from '@/lib/store';

const cache = createCache({
  key: 'css',
  prepend: true, // Ensures styles are injected early
});

export default function ClientWrapper({ children }) {
  return (
    <CacheProvider value={cache}>
      <Provider store={store}>
        {children}
      </Provider>
    </CacheProvider>
  );
}