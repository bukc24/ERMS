const path = require('path')
const bcrypt = require('bcrypt')
const executeQuery = require('../functions/executeQuery')
const {createJWTAndSendResponse} = require('../functions/createJWTAndSendResponse')
const jwt_auth = require('../middleware/jwt_auth')




const index = (req,res)=>{
  //TO DO: LIST NUMBER OF PATIENTS IN ER, NUMBER OF DOCTORS IN ER,
  // LIST THE PATIENTS IN ER AND CLICKING ON A PATIENT REDIRECTS TO /patient/:patientID
  
    res.sendFile(path.join(__dirname,'..','public','index.html'));
}

// LOGIN
const loginView = (req,res)=>{
  
    res.sendFile(path.join(__dirname,'..','public','login.html'));
}

const login = async (req,res)=>{
    const sqlQuery = `SELECT * FROM ER_Receptionist WHERE email = '${req.body.email}'`;
  
    try {
      const result = await executeQuery(sqlQuery);
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
    res.sendFile(path.join(__dirname,'..','public','signup.html'));
}

const signup = async (req,res)=>{
      //body
      console.log(req.body)
      //has the password and create a  user object
      const hashedPassword = await bcrypt.hash(req.body.password,10)
  
      const user = { email:req.body.email, password:hashedPassword}
      
      const sqlQuery = `EXEC AddUser '${user.email}', '${user.password}'`;
  
      try {
        const result=await executeQuery(sqlQuery)
        console.log(result)
        res.status(200)
        res.redirect("/login")
       
      } catch (err) {
        console.error('Error in SignUP query:', err);
        res.status(500).send(err);
      }
  
}


//LOGOUT
const logout = (req,res)=>{
    res.clearCookie("token")
    res.redirect('/login')
}

//PATIENT ADMIT
/* 
GET: A FORM WHERE PATIENT ID IS ENTERED ALONG WITH OTHER DATA FOR ADMITTED
POST: CREATE AN ENTRY IN PatientsInER ; REDIRECT TO THAT PATIENTS DETAIL PAGE
*/
const admitView = (req,res) =>{
  //display form page
}

const admit = (req,res)=>{
  const patientID = req.body.patientID;
    const otherData = req.body.otherData;

    // Create an entry in the PatientsInER array (simulating database)
    

    // Redirect to the detail page of the admitted patient
    res.redirect(`/patient/${patientID}`);
}

//PATIENT REGISTER
/* 
GET: FORM FOR CREATING A PATIENT RECORD
POST: CREATE AN ENTRY IN Patients; REDIRECT TO PREFILLED ADMIT FORM WITH PATIENT ID
    Database-Exec InsertPatient (@patientName, @dob, @gender, @contact, @address, @email, @password)
*/

//EMERGENCY CALL
/* 
GET: FORM FOR ACCEPTING CALLER DETAILS
POST :
    database: Exec InsertCallerDetails @CallerName, @ContactNumber, @Description, @Location
*/


//LAB TEST REQUEST
/* 
GET: FORM FOR REQUESTING LAB TEST
POST: Submit form and redirect to patient page
*/


//MEDICINE REQUEST
/* 
GET:A FORM FOR REQUESTING MEDICINE
POST: Submit form and redirect to patient page
*/


//Patient page
/*
GET: SHOW PATIENT DETAILS, LIKE 
*/




//404
const pageDoesNotExist =  (req, res) => {
  res.status(404).send('<h1>404! Page not found</h1>'); 
}

module.exports ={
    index,
    login,
    loginView,
    signup,
    signupView,
    logout,
    pageDoesNotExist
}