// const mysql = require('mysql2');
// const { Client } = require('ssh2');
// const sshClient = new Client();


// const dbServer = {
//     host: 'webapp-sql-database.cbzocgpmqohp.us-west-1.rds.amazonaws.com',
//     port: '3306',
//     user: 'admin',
//     password: 'funbill123',
//     database: 'funbillDB',
//     timeout: 1700000
// }
// const tunnelConfig = {
//     host: 'ec2-54-215-245-137.us-west-1.compute.amazonaws.com',
//     username: 'ubuntu',
//     privateKey:
//     require('fs').readFileSync('../../../../credentials/WebApp.pem')
// };

// const forwardConfig = {
//     srcHost: 'localhost',
//     srcPort: 3000,
//     dstHost: dbServer.host,
//     dstPort: dbServer.port
// };

// const SSHConnection = new Promise((resolve, reject) => {
//     sshClient.on('ready', () => {
//         sshClient.forwardOut(
//             forwardConfig.srcHost,
//             forwardConfig.srcPort,
//             forwardConfig.dstHost,
//             forwardConfig.dstPort,
//             (err, stream) => {
//                 if (err) reject(err);
//                 const updatedDbServer = {
//                     ...dbServer,
//                     stream
//                 };
//                 const connection =  mysql.createConnection(updatedDbServer);
//                 connection.connect((error) => {
//                 if (error) {
//                     reject(error);
//                 }
//                 resolve(connection);
//                 });
//             }
//         );
//     }).connect(tunnelConfig);
// });

// connection = SSHConnection;
// module.exports = connection;

const mysql = require('mysql');

let connection = mysql.createConnection({
	host : 'funbill-database.cbzocgpmqohp.us-west-1.rds.amazonaws.com',
	database : 'funbillDB',
	user : 'admin',
	password : 'funbill123',
	port     : '3306',
    debug    : true
    // timeout: 1700000
});

module.exports = connection;



