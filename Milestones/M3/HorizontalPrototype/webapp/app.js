const express = require('express');
const app = express();
const path = require('path');
const router = express.Router();

router.get('/', (req,res) => {
  res.sendFile(path.join(__dirname+'/index.html'));
  //__dirname : It will resolve to your project folder.
});

router.get('/:file.png', (req, res) => {
  res.sendFile(path.join(__dirname+'/'+req.params.file+'.png'));
});

router.get('/:file.jpg', (req, res) => {
  res.sendFile(path.join(__dirname+'/'+req.params.file+'.jpg'));
});

router.get('/:file.css', (req, res) => {
  res.sendFile(path.join(__dirname+'/'+req.params.file+'.css'));
});

router.get('/:file', (req, res) => {
  res.sendFile(path.join(__dirname+'/'+req.params.file+'.html'));
});


//add the router
app.use('/', router);
app.listen(process.env.port || 3000);

console.log('Running at Port 3000');