let express = require('express');

let router = express.Router();

let database = require('../database');

router.get("/", (request, response, next) => {
    database.query("SELECT * FROM funBillTransactionLog", (error, data) => {
        if (error) console.log(error);

        response.render('home');
    });
});