const express = require('express')
const {jwt_auth} = require('../../middleware/jwt_auth')
const router = express.Router()
const executeQuery = require('../../functions/executeQuery')
const executeParameterizedQuery = require('../../functions/executeParameterizedQuery')



//routes 
//getting patients
router.route('/patients_in_ER').get(jwt_auth,async (req,res)=>{
    //FRONTEND: fetch('api/patients_in_ER').then(response=>response.json()).then(data=>{console.log(data)})
    query = "Select * from GetPatientsInER();"//patients in ER function

    try {
        const result = await executeQuery(query)
        console.log(result)
        res.json(result)
    }
    catch(error){
        res.status(500).json({error:"Internal Server Error"})
    }
})

router.route('/patients_not_in_ER').get(jwt_auth,async (req,res)=>{
    //FRONTEND: fetch('api/patients_not_in_ER').then(response=>response.json()).then(data=>{console.log(data)})
    query = "Select * from GetPatientsNotInER();"//patients in ER function

    try {
        const result = await executeQuery(query)
        console.log(result)
        res.json(result)
    }
    catch(error){
        res.status(500).json({error:"Internal Server Error"})
    }
})


//searching patients
router.route('/patients_in_ER/:patientID').get(jwt_auth,async (req,res)=>{
    //FRONTEND: fetch('api/patients_in_ER').then(response=>response.json()).then(data=>{console.log(data)})
    const patientID = req.params.patientID;
    query = `Select * from GetPatientsInER() where patientID = ?;`//patients in ER function
    const parameters = [patientID];
    try {
        const result = await executeParameterizedQuery(query,parameters)
        console.log(result)
        res.json(result)
    }
    catch(error){
        res.status(500).json({error:"Internal Server Error"})
    }
})

router.route('/patients_not_in_ER/:patientID').get(jwt_auth,async (req,res)=>{
    //FRONTEND: fetch('api/patients_not_in_ER').then(response=>response.json()).then(data=>{console.log(data)})
    const patientID = req.params.patientID;
    query = `Select * from GetPatientsNotInER() where patientID = ?;`//patients in ER function
    const parameters = [patientID];

    try {
        const result = await executeParameterizedQuery(query,parameters)
        console.log(result)
        res.json(result)
    }
    catch(error){
        res.status(500).json({error:"Internal Server Error"})
    }
})



module.exports= router