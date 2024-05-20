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
router.route('/patients_in_ER/:q').get(jwt_auth,async (req,res)=>{
    //FRONTEND: fetch('api/patients_in_ER/ANY_QUERY').then(response=>response.json()).then(data=>{console.log(data)})
    const q = req.params.q;
    query = `Select * from GetPatientsInER() 
    where patientid=?;`//patients in ER function
    const parameters = [q];
    try {
        const result = await executeParameterizedQuery(query,parameters)
        console.log(result)
        res.json(result)
    }
    catch(error){
        res.status(500).json({error:"Internal Server Error"})
    }
})

router.route('/patients_not_in_ER/:q').get(jwt_auth,async (req,res)=>{
    //FRONTEND: fetch('api/patients_not_in_ER/ANY_QUERY').then(response=>response.json()).then(data=>{console.log(data)})
    const q = req.params.q;
    const query = `Select * from GetPatientsNotInER() 
    where patientid=? or PatientName like '%'+?+'%' or address like '%'+?+'%'  or contact like ?+'%';`//patients in ER function
    const parameters = [q,q,q,q];

    try {
        const result = await executeParameterizedQuery(query,parameters)
        console.log(result)
        res.json(result)
    }
    catch(error){
        res.status(500).json({error:"Internal Server Error"})
    }
})

router.route('/patients_not_in_ER_id/:q').get(jwt_auth,async (req,res)=>{
    //FRONTEND: fetch('api/patients_not_in_ER_id/ANY_QUERY').then(response=>response.json()).then(data=>{console.log(data)})
    const q = req.params.q;
    const query = `Select * from GetPatientsNotInER() 
    where patientid=?;`//patients in ER function
    const parameters = [q];

    try {
        const result = await executeParameterizedQuery(query,parameters)
        console.log(result)
        res.json(result)
    }
    catch(error){
        res.status(500).json({error:"Internal Server Error"})
    }
})

//patients count
router.route('/patients_count').get(jwt_auth,async (req,res)=>{
    //FRONTEND: fetch('api/patient_count').then(response=>response.json()).then(data=>{console.log(data)})

    query = `SELECT dbo.GetNumberOfPatientsInER() AS NumberOfPatientsInER;`//patients in ER function


    try {
        const result = await executeQuery(query)
        console.log(result)
        res.json(result)
    }
    catch(error){
        res.status(500).json({error:"Internal Server Error"})
    }
})


router.route('/patients_count_triage').get(jwt_auth,async (req,res)=>{
    //FRONTEND: fetch('api/patients_count_triage').then(response=>response.json()).then(data=>{console.log(data)})

    query = `SELECT * FROM dbo.GetPatientCountByTriage();`//patients in ER function


    try {
        const result = await executeQuery(query)
        console.log(result)
        res.json(result)
    }
    catch(error){
        res.status(500).json({error:"Internal Server Error"})
    }
})

//getting doctors
router.route('/doctors_in_ER').get(jwt_auth,async (req,res)=>{
    //FRONTEND: fetch('api/doctors_in_ER').then(response=>response.json()).then(data=>{console.log(data)})

    query = `SELECT * FROM dbo.GetDoctorsInER();`//patients in ER function


    try {
        const result = await executeQuery(query)
        console.log(result)
        res.json(result)
    }
    catch(error){
        res.status(500).json({error:"Internal Server Error"})
    }
})

//doctors count


//emergency call
router.route('/available_ambulances').get(jwt_auth,async (req,res)=>{
    //FRONTEND: fetch('api/available_ambulances').then(response=>response.json()).then(data=>{console.log(data)})

    query = `SELECT * FROM dbo.GetAvailableAmbulances();`//patients in ER function


    try {
        const result = await executeQuery(query)
        console.log(result)
        res.json(result)
    }
    catch(error){
        res.status(500).json({error:"Internal Server Error"})
    }
})

router.route('/emergency_call_details').get(jwt_auth,async (req,res)=>{
    //FRONTEND: fetch('api/emergency_call_details').then(response=>response.json()).then(data=>{console.log(data)})

    query = `SELECT * FROM dbo.GetEmergencyCallDetails() ORDER BY DispatchTime DESC;`//patients in ER function


    try {
        const result = await executeQuery(query)
        console.log(result)
        res.json(result)
    }
    catch(error){
        res.status(500).json({error:"Internal Server Error"})
    }
})

router.route('/emergency_call_details_active').get(jwt_auth,async (req,res)=>{
    //FRONTEND: fetch('api/emergency_call_details_active').then(response=>response.json()).then(data=>{console.log(data)})

    query = `SELECT * FROM dbo.GetEmergencyCallDetails() WHERE  ReturnTime is Null ORDER BY DispatchTime DESC;`//patients in ER function


    try {
        const result = await executeQuery(query)
        console.log(result)
        res.json(result)
    }
    catch(error){
        res.status(500).json({error:"Internal Server Error"})
    }
})

router.route('/end_ambulance_request/:requestID').get(jwt_auth,async (req,res)=>{
    //FRONTEND: fetch('api/available_ambulances').then(response=>response.json()).then(data=>{console.log(data)})
    const requestID = req.params.requestID;

    query = `EXEC [dbo].[EndAmbulanceRequest] @RequestID = ?;`//patients in ER function
    const parameters=[requestID]

    try {
        const result = await executeParameterizedQuery(query,parameters)
        console.log(result)
        res.json(result)
    }
    catch(error){
        res.status(500).json({error:"Internal Server Error"})
    }
})




//patient history
router.route('/patient_history/:patientID').get(jwt_auth,async (req,res)=>{
    
    //FRONTEND: fetch('api/patient_history/:patientID').then(response=>response.json()).then(data=>{console.log(data)})
    const patientID = req.params.patientID;
    query = `select * from GetPatientMedicalHistory(?);`//patients in ER function
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



//patient diagnosis history
router.route('/patient_diagnosis_history/:patientID').get(jwt_auth,async (req,res)=>{
    
    //FRONTEND: fetch('/patient_diagnosis_history/:patientID').then(response=>response.json()).then(data=>{console.log(data)})
    const patientID = req.params.patientID;
    query = `EXEC GetPatientDiagnosis @PatientID = ?;`//patients in ER function
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


//patient lab history
router.route('/patient_lab_history/:patientID').get(jwt_auth,async (req,res)=>{
    
    //FRONTEND: fetch('/patient_lab_history/:patientID').then(response=>response.json()).then(data=>{console.log(data)})
    const patientID = req.params.patientID;
    query = `EXEC GetLabResults @PatientID = ?;`//patients in ER function
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




//Discharge a patient
router.route('/patient_discharge/:patientID').get(jwt_auth,async (req,res)=>{
    
    //FRONTEND: fetch('api/patient_discharge/:patientID').then(response=>response.json()).then(data=>{console.log(data)})
    const patientID = req.params.patientID;
    query = `EXEC AddDischargedStatusToPatientInERHistory @PatientID = ?, @Description = 'Patient discharged after treatment.';`//patients in ER function
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