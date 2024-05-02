const jwt = require('jsonwebtoken')
//const pool = require('../db/db_connection')
const executeQuery = require('./executeQuery')
const uniqueID = require('uniqid')



function createJWTAndSendResponse(req, res) {
  try{
  // Create a payload object for JWT
    const jwtPayload = {
      email: req.body.email,
      // Add other user-related information as needed
    };
  
    // Sign the JWT token
    const jwtToken = jwt.sign(jwtPayload, 'thisisdevelopment', { expiresIn: '1d', algorithm: 'HS512' });
  
    
  
    // await executeQuery(jwtSQLQuery)
    //   .then(() => {
    //     res.cookie("token",jwtToken,{
    //       httpOnly:true,
    //     })
    //     res.status(200).json({ jwt: jwtToken });
    //   })
    //   .catch((error) => {
    //     console.error('Error in the JWT SQL query:', error);
    //     res.status(500).send(error);
    //   });



    res.cookie("token",jwtToken,{
     httpOnly:true,
    });
    res.status(200);
  }
  catch(err){
    console.error('Error in the JWT SQL query:', error);
     res.status(500).send(error);
  }

  }




exports.createJWTAndSendResponse = createJWTAndSendResponse;
