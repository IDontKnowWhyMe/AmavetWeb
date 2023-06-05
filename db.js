if (process.env.NODE_ENV !== "production"){
    require("dotenv").config()
}

const mysql = require('mysql2/promise')


// MySQL connection details
const dbConfig = {
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME
}

// Initialize MySQL connection pool
const pool = mysql.createPool(dbConfig)

pool.getConnection()
  .then(function(connection) {
    console.log(`Connected to database: ${dbConfig.database}`);
    connection.release();
  })
  .catch(function(error) {
    console.error(error.message);
  });

module.exports = pool;