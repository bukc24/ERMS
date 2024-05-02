const express = require('express')
const path = require('path')
const bcrypt = require('bcrypt')
const cookieParser = require('cookie-parser');
const executeQuery = require('./functions/executeQuery')
const {createJWTAndSendResponse} = require('./functions/createJWTAndSendResponse')
const {jwt_auth} = require('./middleware/jwt_auth')


const app = express();
const PORT = process.env.PORT || 3000;

//middleware
app.use(express.static('./public'));
app.use(express.json())
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());


//test routes
app.get('/hi' , async(req,res)=>{
  try{
    const result=await executeQuery("select * from doctor")
    console.log(result)

    res.sendFile(path.join(__dirname, 'public','index.html'))
  }catch(err){
    console.log(err)
  }
 
})
//login
app.get('/login', async (req, res) => {
    
    res.sendFile(path.join(__dirname, 'public','login.html'))
  }).post('/login', async (req, res) => {

  
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
          res.redirect("/secret")
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
  });

                    //signup
app.get('/signup',async (req,res)=>{
    res.sendFile(path.join(__dirname, 'public','signup.html'))
}).post('/signup',async (req,res)=>{
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

})


app.get('/logout',(req,res)=>{
  res.clearCookie("token")
  res.redirect('/login')
})

app.get('/secret',jwt_auth , (req,res)=>{
    res.sendFile(path.join(__dirname, 'public','index.html'))
})




//server
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});