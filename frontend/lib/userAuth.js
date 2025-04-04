async function signUp(email, password) {
  const res = await fetch('http://localhost:3000/users', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ user: { email, password } }),
    credentials: 'include',  // Send/receive cookies
  });
  const data = await res.json();
  if (res.ok) {
    document.cookie = `token=${data.token}; path=/; HttpOnly; Secure; SameSite=Strict`;
  }
  return data;
}

async function signIn(email, password) {
  const res = await fetch('http://localhost:3000/users/sign_in', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ user: { email, password } }),
    credentials: 'include',
  });
  const data = await res.json();
  if (res.ok) {
    document.cookie = `token=${data.token}; path=/; HttpOnly; Secure; SameSite=Strict`;
  }
  return data;
}

async function signOut() {
  const res = await fetch('http://localhost:3000/users/sign_out', {
    method: 'DELETE',
    credentials: 'include',
  });
  if (res.ok) {
    document.cookie = 'token=; path=/; expires=Thu, 01 Jan 1970 00:00:00 GMT';  // Clear cookie
  }
  return res.ok;
}
