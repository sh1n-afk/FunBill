let express = require('express');
let router = express.Router();
let database = require('../DB setup');

router.get('/', (request, response, next) => {
    let query = "SELECT * FROM Accounts";

    database.query(query, (err, data) => {

        if (err) console.log(err);

        response.render('homepage', {title: 'Test Response...', action: 'list', filename: 'homepage.html'}, )
    });
});

module.exports= router;