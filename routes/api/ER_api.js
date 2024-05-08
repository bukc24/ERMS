const express = require('express')
const {jwt_auth} = require('../../middleware/jwt_auth')
const router = express.Router()
const executeQuery = require('../../functions/executeQuery')




//routes 
router.route('/patients_in_ER').get(jwt_auth,async (req,res)=>{
    //FRONTEND: fetch('api/patients_in_ER').then(response=>response.json()).then(data=>{console.log(data)})
    query = "Select * from patient p join on patientsINER pe where p.id=pe.id"//patients in ER function

    try {
        const result = await executeQuery(query)
        console.log(result)
        res.json(result)
    }
    catch(error){
        res.status(500).json({error:"Internal Server Error"})
    }
})



module.exports= router