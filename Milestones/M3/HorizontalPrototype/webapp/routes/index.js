let express = require('express');
let router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index');
});

router.get('/about', (req, res, next) =>{
  res.render('about');
});

router.get('/signup', (req, res, next) => {
  res.render('signup');
});

router.get('/login', (req, res, next) => {
  res.render('login');
});

router.get('/faq', (req, res, next) => {
  res.render('faq');
});

router.get('/privacypolicy', (req, res, next) => {
  res.render('privacypolicy');
});

router.get("/home", (req, res, next) => {
    database.query("SELECT * FROM funBillTransactionLog", (error, data) => {
        if (error) console.log(error);

        response.render('home');
    });
});

module.exports = router;
