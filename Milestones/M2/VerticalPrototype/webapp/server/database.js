const mysql = require('mysql');

var connection = mysql.createConnection({
	host : 'webapp-sql-database.cbzocgpmqohp.us-west-1.rds.amazonaws.com',
	database : 'funbillDB',
	user : 'admin',
	password : 'funbill123'
});

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

module.exports = connection;