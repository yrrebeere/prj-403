require('dotenv').config();

// const username = process.env.USERNAME;
const username = 'admin';
const password = process.env.PASSWORD;
const database = process.env.DATABASE;
// const host = process.env.HOST;
// const host = "localhost";
const host = "db-mysql-nyc3-39234-do-user-15490202-0.c.db.ondigitalocean.com";
const node_env = process.env.NODE_ENV;

const config = {
    dev : {
        db : {
            username,
            password,
            database,
            host
        }
    },
    test : {},
    prod : {
        db : {
            username,
            password,
            database,
            host
        }
    }
}

module.exports = config[node_env];
