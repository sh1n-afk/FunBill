import React from 'react';
import {
  Button,
  Drawer,
  DrawerOverlay,
  DrawerContent,
  DrawerCloseButton,
  DrawerHeader,
  DrawerBody,
  DrawerFooter,
  Input,
  IconButton,
  useDisclosure,
  Heading,
  Divider,
  Text,
} from '@chakra-ui/react';
import { HamburgerIcon } from '@chakra-ui/icons';

function Sidebar() {
  const { isOpen, onOpen, onClose } = useDisclosure();
  const btnRef = React.useRef();

  return (
    <>
      <IconButton
        ref={btnRef}
        onClick={onOpen}
        icon={<HamburgerIcon />}
        variant="ghost"
      ></IconButton>
      <Drawer
        isOpen={isOpen}
        placement="left"
        onClose={onClose}
        finalFocusRef={btnRef}
      >
        <DrawerOverlay />
        <DrawerContent justifyContent={'space-evenly'} p={3}>
          <DrawerCloseButton />
          <DrawerHeader>
            <Heading>
              Dashboard
            </Heading>
          </DrawerHeader>

          <DrawerBody p={3}>
            <Heading>Recent</Heading>
            <Text>Transaction 1</Text>
            <Text>Transaction 1</Text>
            <Text>Transaction 1</Text>
            <Text>Transaction 1</Text>
            <Divider></Divider>
            <Heading>Groups</Heading>
            <Text>Group 1</Text>
            <Text>Group 1</Text>
            <Text>Group 1</Text>
            <Text>Group 1</Text>
            <Divider></Divider>
            <Heading>Friends</Heading>
            <Text>Friend 1</Text>
            <Text>Friend 1</Text>
            <Text>Friend 1</Text>
            <Text>Friend 1</Text>
            
          </DrawerBody>
          <Input placeholder="Invite friend by email..." />
          <DrawerFooter>
            
            <Button variant="outline" mr={3} onClick={onClose}>
              Cancel
            </Button>
            <Button colorScheme="teal">Invite</Button>
          </DrawerFooter>
        </DrawerContent>
      </Drawer>
    </>
  );
}
export default Sidebar;
