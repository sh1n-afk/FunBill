const express = require('express');

const router = express.Router();

const database = require('../database');

router.get("/", (request, response, next) => {
	let query = `SELECT * FROM Account`;
	database.query(query, (error, data) => {
		if (error) console.log(error);

		response.render('sample_data', {title: 'Test pull from SQL: funbillDB', action: 'display', sampleData:data});
	});
});

router.get("/:searchData", (request, response, next) => {
	let query = `SELECT * FROM Account`;
	console.log("Request: " + request.searchData);
	if (request.query.searchData !== undefined && request.params.searchData !== null) {
		query = `SELECT * FROM Account WHERE username = "${request.params.searchData.username}"`;
	}
	response.send(query);
	database.query(query, (error, data) => {
		if (error) console.log(error);

		response.render('sample_data', {title: 'Test pull from SQL: funbillDB', action: 'display', sampleData:data});
	});
});

router.get("/search")

router.get("/add", (request, response, next) => {
	response.render('sample_data', {title: 'Test Pull from webpage: sample_data/add', action: 'add'});
});

router.post('/add_sample_data', (request, response, next) => {
	let username = request.body.username;
	let email = request.body.email;
	let birthday = request.body.birthday;
	let password = request.body.password;

	let query = `INSERT INTO Account (userName, email, birthday, userPassword, numTransactions) VALUES ("${username}", "${email}", "${birthday}", "${password}", "${0}")`;

	database.query(query, (error, data) => {
		if (error) console.log(error);

		else response.redirect("/sample_data");
	});
});

router.get('/edit/:id', (request, response, next) => {

	let id = request.params.id;

	let query = `SELECT * FROM Account WHERE account_Id = "${id}"`;

	database.query(query, function(error, data){

		response.render('sample_data', {title: 'Edit MySQL Table Data', action:'edit', sampleData:data[0]});

	});

});

router.post('/edit/:id', (request, response, next) => {
	let id = request.params.id;
	let username = request.params.username;
	let email = request.params.email;
	let birthday = request.params.birthday;

	let query = `
	UPDATE Account
	SET username = "${username}",
	email = "${email}",
	birthday = "${birthday}"
	WHERE account_Id = "${id}"
	`;

	database.query(query, (error, data) => {
		if (error) console.log(error);

		else response.redirect("/sample_data");
	});
});

router.get('/searchbar/:searchQuery', (request, response, next) => {
    console.log(request.params);

    let query = `SELECT * FROM Account WHERE account_Id = "${id}"`;

    database.query(query, (error, data) => {
        if (error) console.log(error);

        else response.render('sample_data', {title: 'Search MySQL Table Data', action:'search', searchData:data});
    });
});

// function searchTest(){
// 	let searchText = document.getElementById('searchBar')
// 	database.query(`SELECT * FROM Account WHERE username = '${searchText}'`, (error, data) => {
// 		if (error) console.log(error);

// 		console.log(JSON.stringify(data));
// 	});
// }

// module.exports = {
// 	router
// };



module.exports = router;