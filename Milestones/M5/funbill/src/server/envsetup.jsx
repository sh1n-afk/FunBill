import { env } from 'process'


// Database credentials
env.DB_HOST = 'webapp-sql-database.cbzocgpmqohp.us-west-1.rds.amazonaws.com';
env.DB_PORT = '3306';
env.DB_USERNAME = 'admin';
env.DB_PASSWORD = 'funbill123';
env.DB_DATABASE = 'funbillDB';

// SSH credentials
env.DB_SSH_HOST = 'ec2-54-215-245-137.us-west-1.compute.amazonaws.com';
env.DB_SSH_USER = 'ubuntu';