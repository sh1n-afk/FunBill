import React from 'react';
import { ChakraProvider, Box, theme } from '@chakra-ui/react';
import { Routes, Route } from 'react-router-dom';

import LoginPage from './pages/Login';
import SignupPage from './pages/Signup';
import Template from './pages/Template';

import Navbar from './components/ui/navbar';

function App() {
  return (
    <ChakraProvider theme={theme}>
      <Navbar />
      <Box textAlign={'center'} fontSize="xl">
        <Routes>
          <Route path="/" element={<Template />} />
          <Route path="login" element={<LoginPage />} />
          <Route path="signup" element={<SignupPage />} />
        </Routes>
      </Box>
    </ChakraProvider>
  );
}

export default App;
