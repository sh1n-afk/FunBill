var express = require('express');
var router = express.Router();
var database = require('../DB setup');

router.get('/', (request, response, next) => {
    var query = "SELECT * FROM Accounts";
    database.query(query, (err, data) => {
        if (err) console.log(err);
        response.render('homepage', {title: 'Test Response...', action: 'list', filename: 'homepage.html'}, )
    });
});

module.exports= router;