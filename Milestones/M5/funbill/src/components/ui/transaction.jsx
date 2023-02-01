import {
  IconButton,
  Container,
  Card,
  Flex,
  Menu,
  MenuButton,
  MenuList,
  MenuItem,
  Text,
} from '@chakra-ui/react';

import { HamburgerIcon } from '@chakra-ui/icons';

const Transaction = props => {
  const { date, desc, price } = props;

  return (
    <Container>
      <Card size="sm" variant="outline" p={3} justifyContent="center">
        <Flex direction="row" justifyContent={'space-between'}>
          <Text fontSize="lg">{date}</Text>
          <Text fontSize="lg" textAlign="center">
            {desc}
          </Text>
          <Text fontSize="lg" textAlign="center">
            {price}
          </Text>
          <Menu>
            <MenuButton
              as={IconButton}
              icon={<HamburgerIcon />}
              variant="ghost"
            >
              Actions
            </MenuButton>
            <MenuList>
              <MenuItem>Pay</MenuItem>
              <MenuItem>Edit</MenuItem>
              <MenuItem>Archive</MenuItem>
              <MenuItem>Delete</MenuItem>
            </MenuList>
          </Menu>
        </Flex>
      </Card>
    </Container>
  );
};

export default Transaction;
