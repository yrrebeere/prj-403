require('dotenv').config();

const username = process.env.USERNAME;
const password = process.env.PASSWORD;
const database = process.env.DATABASE;
// const host = process.env.HOST;
const host = "localhost";
// const node_env = process.env.NODE_ENV;

const config = {
    db : {
        username,
        password,
        database,
        host
    }
}

module.exports = config;
