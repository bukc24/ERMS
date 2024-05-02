const path = require('path')
const bcrypt = require('bcrypt')
const executeQuery = require('../functions/executeQuery')
const {createJWTAndSendResponse} = require('../functions/createJWTAndSendResponse')
require('dotenv').config({ path: '../.env' });

const index = (req,res)=>{
        res.sendFile(path.join(__dirname,'..','public','index.html'));
}


// LOGIN
const loginView = (req,res)=>{
    res.sendFile(path.join(__dirname,'..','public','login.html'));
}

const login = async (req,res)=>{
    const sqlQuery = `SELECT * FROM ER_Receptionist WHERE email = '${req.body.email}'`;
  
    try {
      const result = await executeQuery(process.env.DB_SERVER,sqlQuery);
      console.log(result)
      if (result.length != 0) {
  
        const userData = result[0];
  
    
        const ifMatch = await bcrypt.compare(req.body.password, userData.password)
    
        console.log(ifMatch)
    
        if (ifMatch === true) {
          createJWTAndSendResponse(req, res)
          res.redirect("/dashboard")
        } else {
          res.status(401).send({ error: "Password does not match" });
        }
       
      } else {
        res.status(404).send({error: "No user found"})
      }
     
    } catch (err) {
      console.error('Error in login query:', err);
      res.status(500).send(err);
    }
}

//SIGN UP
const signupView = (req,res)=>{
    res.sendFile(path.join(__dirname,'..','public','login.html'));
}

const signup = async (req,res)=>{
      //body
      console.log(req.body)
      //has the password and create a  user object
      const hashedPassword = await bcrypt.hash(req.body.password,10)
  
      const user = { email:req.body.email, password:hashedPassword}
      
      const sqlQuery = `EXEC AddUser '${user.email}', '${user.password}'`;
  
      try {
        const result=await executeQuery(process.env.DB_SERVER,sqlQuery)
        console.log(result)
        res.status(200)
        res.redirect("/login")
       
      } catch (err) {
        console.error('Error in SignUP query:', err);
        res.status(500).send(err);
      }
  
}


//logout
const logout = (req,res)=>{
    res.clearCookie("token")
    res.redirect('/login')
}

module.exports ={
    index,
    login,
    loginView,
    signup,
    signupView,
    logout,
}