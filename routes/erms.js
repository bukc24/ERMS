const express = require('express')
const {jwt_auth} = require('../middleware/jwt_auth')
const router = express.Router()
const api = require('./api/ER_api')



//api router
router.use('/api',api)

//controller  functions
const {
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
} = require("../controllers/erms")



//routes 
router.route('/').get(base)
router.route('/dashboard').get(jwt_auth,index)
router.route('/login').get(loginView).post(login)
router.route('/signup').get(signupView).post(signup)
router.route('/logout').get(logout)
router.route('/emergency_call').get(jwt_auth,emergency)
router.route('/emergency_call/record').get(jwt_auth,emergencyRecordView).post(jwt_auth,emergencyRecord)
router.route('/register').get(jwt_auth,registerView).post(jwt_auth,register)
router.route('/admit').get(jwt_auth,admitPre)
router.route('/admit/:patientID').get(jwt_auth,admitView).post(jwt_auth,admit)
router.route('/patient/:patientID').get(jwt_auth,patientDetailsView)
// router.route('/patient/:patientID/lab')
// router.route('/patient/:patientID/medicine')
router.route('*').all(pageDoesNotExist)


module.exports= router