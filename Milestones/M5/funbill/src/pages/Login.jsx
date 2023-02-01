import React, { useState } from 'react';

const LoginForm = () => {
  // Use the useState hook to store the form values in state
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [rememberMe, setRememberMe] = useState(false);

  // Handle form submission
  const handleSubmit = (event) => {
    event.preventDefault();

    // Perform login logic here, such as sending the email and password to a server for authentication
  };

  return (
    <form onSubmit={handleSubmit}>
      <h2> Log Into Account </h2>
      <br />
      <label htmlFor="email">Email:</label>
      <input
        type="email"
        id="email"
        value={email}
        onChange={(event) => setEmail(event.target.value)}
      />
      <label htmlFor="password">Password:</label>
      <input
        type="password"
        id="password"
        value={password}
        onChange={(event) => setPassword(event.target.value)}
      />
      <label htmlFor="rememberMe">
        <input
          type="checkbox"
          id="rememberMe"
          checked={rememberMe}
          onChange={(event) => setRememberMe(event.target.checked)}
        />
        Remember me
      </label>
      
      <button type="submit">Login</button>
      <br />
      <a href="#" onClick={() => alert('Forgot password clicked')}>
        Forgot password?
      </a>
    </form>
  );
};

export default LoginForm;