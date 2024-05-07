const express = require('express')
const {jwt_auth} = require('../../middleware/jwt_auth')
const router = express.Router()
const executeQuery = require('../../functions/executeQuery')
require('dotenv').config({ path: '../../.env' });



//routes 
router.route('/patients_in_ER').get(jwt_auth,async (req,res)=>{
    //FRONTEND: fetch('api/patients_in_ER').then(response=>response.json()).then(data=>{console.log(data)})
    query = "Select * from doctor"//patients in ER function

    try {
        const result = await executeQuery(process.env.DB_SERVER,query)
        console.log(result)
        res.json(result)
    }
    catch(error){
        res.status(500).json({error:"Internal Server Error"})
    }
})



module.exports= router