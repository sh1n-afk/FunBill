const { response } = require('express');
const express = require('express');
const { readFile } = require('fs').promises;
const { request } = require('http');

const app = express();

app.get('/', async (request, response) => {

  response.send( await readFile('./index.html', 'utf8'));

});

app.use(express.static('./'));

app.listen(process.env.Port || 3000, () => console.log('process available http://localhost:3000'))