import {
  Flex,
  Box,
  Heading,
  Spacer,
  ButtonGroup,
  Button,
  InputGroup,
  InputLeftElement,
  Input,
  Link,
} from '@chakra-ui/react';

import { Link as ReactLink } from 'react-router-dom';
import { SearchIcon } from '@chakra-ui/icons';
import { ColorModeSwitcher } from '../../utils/ColorModeSwitcher';

import Sidebar from './sidebar';

const Navbar = () => {
  return (
    <Flex minWidth="max-content" align="center" gap="2" direction={'row'} p={3}>
      <Sidebar />

      <Box p="2">
        <Heading size="xl">
          <Link as={ReactLink} to="/">
            Funbill
          </Link>
        </Heading>
      </Box>
      <Spacer />

      <InputGroup>
        <InputLeftElement pointerEvents="none" children={<SearchIcon />} />
        <Input placeholder="Search for users, transactions, etc..." />
      </InputGroup>

      <ButtonGroup gap="2">
        <ColorModeSwitcher />
        <Button colorScheme="teal" variant="outline">
          <Link as={ReactLink} to="/login">
            Login
          </Link>
        </Button>
        <Button colorScheme="teal">
          <Link as={ReactLink} to="/signup">
            Signup
          </Link>
        </Button>
      </ButtonGroup>
    </Flex>
  );
};

export default Navbar;
