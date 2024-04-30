const sql = require("msnodesqlv8");
const connectionString = "server=DESKTOP-IJD5VE0;Database=showcase2;Trusted_Connection=Yes;Driver={SQL Server Native Client 11.0}";//SERVER and DATABASE NAME


async function executeQuery(query) {
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