//import dotenv from 'dotenv';
const dotenv = require('dotenv');

module.exports = {
   db_host: process.env.HOST,
   db_user: process.env.USER,
   db_password: process.env.PASSWORD,
}