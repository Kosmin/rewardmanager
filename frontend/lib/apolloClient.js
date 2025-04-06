import { ApolloClient, InMemoryCache, HttpLink } from '@apollo/client';

const client = new ApolloClient({
  link: new HttpLink({
    uri: 'http://0.0.0.0:3000/graphql',
    credentials: 'include',
  }),
  cache: new InMemoryCache(),
});

export default client;
