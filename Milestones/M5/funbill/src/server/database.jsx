const express = require('express');
const bodyParser = require('body-parser'); 

const app = express(); 
app.use(bodyParser.json());
const mysql = require('mysql');

const connection = mysql.createConnection({
	host : 'funbill-database.cbzocgpmqohp.us-west-1.rds.amazonaws.com',
	database : 'funbillDB',
	user : 'admin',
	password : 'funbill123',
	port     : '3306',
    debug    : true
    // timeout: 1700000
});

module.exports = connection;

connection.connect(function(error){
	if(error)
	{
		throw error;
	}
	else
	{
		console.log('MySQL Database is connected Successfully');
	}
});

// app.use(
// 	connection(mysql,{
// 			host: 'webapp-sql-database.cbzocgpmqohp.us-west-1.rds.amazonaws.com', 
// 			user: 'admin',
// 			password : 'funbill123',
// 			port : 3306,
// 			database:'funbillDB'
// 	},'pool')); //or single

//  app.post('/addExpense',(req,res)=>{

// 	let {date,desc,price} = req.body;


// 	if(!date) return res.status(400).json('Date invalid');
// 	if(!desc) return res.status(400).json('Description can\'t be blank');
// 	if(!price) return res.status(400).json('Price can\'t be $0');

// 	var data={book_name:book_name,
// 						author:author,
// 					price:price};

// 	 app.listen(3000, ()=> {
// console.log(`app is running on port 3000`);
// 	});
// });