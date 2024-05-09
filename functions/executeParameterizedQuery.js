const sql = require("msnodesqlv8");
require('dotenv').config();

async function executeParameterizedQuery(query, parameters) {
    const connectionString = `server=${process.env.DB_SERVER};Database=HospitalManagementSystem;Trusted_Connection=Yes;Driver={ODBC Driver 17 for SQL Server}`;//SERVER and DATABASE NAME
    return new Promise((resolve, reject) => {
        sql.query(connectionString, query, parameters, (err, rows) => {
            if (err) {
                reject(err);
            } else {
                resolve(rows);
            }
        });
    });
}

module.exports = executeParameterizedQuery;