let express = require('express');

let router = express.Router();

let database = require('../database');

router.get("/", (request, response, next) => {
    database.query("SELECT * FROM funBillTransactionLog", (error, data) => {
        if (error) console.log(error);

        response.render('homepage', {transactionData: data, transactionAction: "display"});
    });
});


router.get("/homepage/", (request, response, next) => {
    database.query("SELECT * FROM funBillTransactionLog", (error, data) => {
        if (error) console.log(error);

        response.render('homepage', {transactionData: data});
    });
});

// The flow for adding transactions will be:
// Click add button -> redirect to /homepage/addTransaction
// router.get(/homepage/addTransaction) will render the add page
// Submit button -> redirect to /homepage/addTransactionData -> redirect to /homepage/

router.get("/homepage/addTransaction", (request, response, next) => {
    response.render('homepage', {transactionData: undefined, transactionAction: "add"});
});

router.post("/homepage/addTransactionData", (response, request, next) => {
    /*  This will pull the values from the page in the body of
        `/homepage/addTransactionData` with the given name + id
        (I think it's looking for one or the other, but I don't
        know which).
    */
    let category = request.body.transactionCategory;
    let title = request.body.transactionTitle;
    let completed = request.body.transactionCompleted;
    let totalAmountDue = request.body.transactionTotalAmount;
    let individualAmount = request.body.transactionIndividualAmount;

    const query = `INSERT INTO funBillTransaction (funBillTransaction_id, Category, Title, Completed, totalAmountDue, individualAmount) VALUES ("${category}", "${title}", "${completed}", "${totalAmountDue}", "${individualAmount}")`;

    database.query(query, (error, data) => {
        if (error) console.log(error);

        else response.redirect("/homepage/");
    });
});

module.exports = router;