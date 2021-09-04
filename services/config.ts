import dotenv from 'dotenv'

const config = {
   db_host: process.env.HOST,
   db_user: process.env.USER,
   db_password: process.env.PASSWORD,
}

export default config;