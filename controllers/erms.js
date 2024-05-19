const path = require('path')
const bcrypt = require('bcrypt')
const executeQuery = require('../functions/executeQuery')
const executeParameterizedQuery = require('../functions/executeParameterizedQuery')
const {createJWTAndSendResponse} = require('../functions/createJWTAndSendResponse')
const jwt_auth = require('../middleware/jwt_auth')



const base = (req,res)=>{
  res.redirect('/dashboard')
}


const index = (req,res)=>{
  //TO DO: LIST NUMBER OF PATIENTS IN ER, NUMBER OF DOCTORS IN ER,
  // LIST THE PATIENTS IN ER AND CLICKING ON A PATIENT REDIRECTS TO /patient/:patientID
  
    res.sendFile(path.join(__dirname,'..','public','emergency','index-2.html'));
}

// LOGIN
const loginView = (req,res)=>{
  
    res.sendFile(path.join(__dirname,'..','public','emergency','login.html'));
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
    res.sendFile(path.join(__dirname,'..','public','emergency','register.html'));
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
const admitPre = (req,res) =>{
  //display form page
  res.sendFile(path.join(__dirname,'..','public','emergency','patient-admit.html'));
} 

const admitView = (req,res) =>{
  //display form page
  res.sendFile(path.join(__dirname,'..','public','emergency','patient-admit-form.html'));
}

const admit = async (req,res)=>{
  const patientID = req.body.id
  const triage = req.body.triage
  const requestID = req.body.request
  const doctorID = req.body.doctor
  const description = req.body.description

  // sql query
  const sqlQuery = `EXEC AddPatientToER 
  @PatientID = ?,
  @RequestID = ?,
  @Status = ?,
  @Triage = ?,
  @DoctorID = ?,
  @Description = ?;`

  parameters = [patientID,requestID,'Admitted',triage,doctorID,description]

  try {
    const result=await executeParameterizedQuery(sqlQuery,parameters)
    res.status(200)
    //redirect to patient details page
    res.redirect('/')
   
  } catch (err) {
    console.error('Error in registering patient', err);
    res.status(500).send(err);
  }
 
}

//PATIENT REGISTER
/* 
GET: FORM FOR CREATING A PATIENT RECORD
POST: CREATE AN ENTRY IN Patients; REDIRECT TO PREFILLED ADMIT FORM WITH PATIENT ID
    Database-Exec InsertPatient (@patientName, @dob, @gender, @contact, @address, @email, @password)
*/
const registerView = (req,res)=>{
  res.sendFile(path.join(__dirname,'..','public','emergency','add-patient.html'));
}

const register = async(req,res)=>{
  const name = req.body.name
  const dob = req.body.dob
  const contact = req.body.contact
  const gender = req.body.gender
  const address = req.body.address
  const email = req.body.email === undefined ? '' : req.body.email;
  const password = req.body.password === undefined ? '' : req.body.password;

  // Create an entry in database
  let sqlQuery;
  let parameters;
  if (email === '' && password ===''){
    sqlQuery = `EXEC InsertPatient ?,?,?,?,?,NULL,NULL`;
    parameters = [name,dob,gender,contact,address]
  }
  else{
    sqlQuery = `EXEC InsertPatient ?,?,?,?,?,?,?;`;
    parameters = [name,dob,gender,contact,address,email,password]
  }
      try {
        const result=await executeParameterizedQuery(sqlQuery,parameters)
        console.log(result[0].Column0)
        res.status(200)
        //redirect to patient admit page
        res.redirect("/admit/"+result[0].Column0)
       
      } catch (err) {
        console.error('Error in registering patient', err);
        res.status(500).send(err);
      }
  
  
}


//EMERGENCY CALL
/* 
GET: PAGE OF EMERGENCY CALLS

GET: FORM FOR ACCEPTING CALLER DETAILS

POST :
    database: Exec InsertCallerDetails @CallerName, @ContactNumber, @Description, @Location
*/
const emergency = (req,res) => {
  res.sendFile(path.join(__dirname,'..','public','emergency','emergency-call.html'));
}

const emergencyRecordView = (req,res)=>{
  res.sendFile(path.join(__dirname,'..','public','emergency','add-emergency-details.html'));
}

const emergencyRecord = async (req,res)=>{
  const name = req.body.name
  const contact = req.body.contact
  const description = req.body.description
  const location = req.body.location
  
  const sqlQuery = `EXEC InsertCallerDetails ?, ?, ?, ?`;
  parameters = [name,contact,description,location]
  try {
    const result=await executeParameterizedQuery(sqlQuery,parameters)
    console.log(result)
    res.status(200)
    res.redirect("/emergency_call")
    
  } catch (err) {
    console.error('Error in SignUP query:', err);
    res.status(500).send(err);
  }
}

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
const patientDetailsView = (req,res)=>{
  res.sendFile(path.join(__dirname,'..','public','emergency','patient-details.html'));
}




//404
const pageDoesNotExist =  (req, res) => {
  res.status(404).sendFile(path.join(__dirname,'..','public','emergency','error-404.html'));
}

module.exports ={
    base,
    index,
    login,
    loginView,
    signup,
    signupView,
    logout,
    emergency,
    emergencyRecordView,
    emergencyRecord,
    registerView,
    register,
    admitPre,
    admitView,
    admit,
    patientDetailsView,
    pageDoesNotExist
}