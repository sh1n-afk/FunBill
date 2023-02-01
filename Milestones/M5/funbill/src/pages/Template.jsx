import {
  ChakraProvider,
  Grid,
  Box,
  VStack,
  Text,
  Link,
  Code,
  theme,
} from '@chakra-ui/react';

import Transaction from '../components/ui/transaction';
import CreateTransaction from '../components/form/createTransaction';
import connection from '../server/database.jsx';
// import {Express} from 'express';

const express = require('express');
// const bodyParser = require('body-parser');
const app = express(); 


let transaction;
function getDBData(){
  connection.connect(function(err) {
    if (err) throw err;
    console.log("Connected!");
  });

  app.use(connection);

  app.get('/posts', (req, res) => {
    connection.query("SELECT * FROM 'funBillTransactions';", (err, results, fields) => {
      if(err) throw err;
      console.log(results[0]);
    });
  });
}

export const Template = () => {
  getDBData();
  return (
    <ChakraProvider theme={theme}>
      <Box textAlign="center" fontSize="xl" p={5}>
        <Grid minH="100vh" p={5}>
          <VStack spacing={5}>
            <CreateTransaction />
            <Text>
              Edit <Code fontSize="xl">src/App.js</Code> and save to reload.
            </Text>
            <Link
              color="teal.500"
              href="https://chakra-ui.com"
              fontSize="2xl"
              target="_blank"
              rel="noopener noreferrer"
            >
              Learn Chakra
            </Link>
            <Transaction
              date="11/11/22"
              desc="Walmart"
              price="$75.39"
            ></Transaction>
            <Transaction
              date="11/11/22"
              desc="Walmart"
              price="$75.39"
            ></Transaction>
            <Transaction
              date="11/11/22"
              desc="Walmart"
              price="$75.39"
            ></Transaction>
            <Transaction
              date="11/11/22"
              desc="Walmart"
              price="$75.39"
            ></Transaction>
          </VStack>
        </Grid>
      </Box>
    </ChakraProvider>
  );
};

export default Template;