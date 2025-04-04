'use client';

import { CacheProvider } from '@emotion/react';
import createCache from '@emotion/cache';
import { useServerInsertedHTML } from 'next/navigation';
import { useState } from 'react';
import { Provider } from 'react-redux';
import { ApolloProvider } from '@apollo/client';
import { store } from '@/lib/store';
import client from '@/lib/apolloClient';

export default function EmotionCacheProvider({ children }) {
  const [cache] = useState(() => {
    const cache = createCache({ key: 'css', prepend: true });
    return cache;
  });

  useServerInsertedHTML(() => {
    const styles = Object.values(cache.inserted).join('');
    return <style data-emotion={`${cache.key} ${Object.keys(cache.inserted).join(' ')}`}>{styles}</style>;
  });

  return (
    <CacheProvider value={cache}>
      <Provider store={store}>
        <ApolloProvider client={client}>{children}</ApolloProvider>
      </Provider>
    </CacheProvider>
  );
}
