app.get('/login', async (req, res) => {
    res.sendFile(path.join(__dirname, 'frontend', 'Html', 'Login.html'))
  }).post('/login', async (req, res) => {
    console.log(req.body)
  
    const sqlQuery = `SELECT * FROM USERS WHERE email = '${req.body.email}'`;
  
    try {
      const result = await executeQuery(sqlQuery);
      console.log(result)
      if (result.length != 0) {
  
        const userData = result[0];
  
    
        const ifMatch = await bcrypt.compare(req.body.password, userData.password)
    
        console.log(ifMatch)
    
        if (ifMatch == true) {
          route_functions.createJWTAndSendResponce(req, res)
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