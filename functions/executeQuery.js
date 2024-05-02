const sql = require("msnodesqlv8");

async function executeQuery(server,query) {
    const connectionString = `server=${server};Database=HospitalManagementSystem;Trusted_Connection=Yes;Driver={ODBC Driver 17 for SQL Server}`;//SERVER and DATABASE NAME
    return new Promise((resolve, reject) => {
      sql.query(connectionString, query, (err, rows) => {
        if (err) {
          reject(err);
        } else {
          resolve(rows);
        }
      });
    });
  }



  module.exports = executeQuery