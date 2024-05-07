const express = require('express')
const {jwt_auth} = require('../middleware/jwt_auth')
const router = express.Router()
const api = require('./api/ER_api')



//api router
router.use('/api',api)

//controller  functions
const {
    index,
    login,
    loginView,
    signup,
    signupView,
    logout,
    pageDoesNotExist,
} = require("../controllers/erms")



//routes 
router.route('/dashboard').get(jwt_auth,index)
router.route('/login').get(loginView).post(login)
router.route('/signup').get(signupView).post(signup)
router.route('/logout').get(logout)
//router.route('/call')
//router.route('/admit').get(admitView).post(admit)
// router.route('/patient/:patientID').get((req,res)=>{res.send(req.params)})
// router.route('/patient/:patientID/lab')
// router.route('/patient/:patientID/medicine')
router.route('*').all(pageDoesNotExist)


module.exports= router