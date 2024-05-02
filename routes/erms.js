const express = require('express')
const {jwt_auth} = require('../middleware/jwt_auth')
const router = express.Router()

//controller  functions
const {
    index,
    login,
    loginView,
    signup,
    signupView,
    logout,
} = require("../controllers/erms")


//routes 
router.route('/dashboard').get(jwt_auth,index)
router.route('/login').get(loginView).post(login)
router.route('/signup').get(signupView).post(signup)
router.route('/logout').get(logout)

module.exports= router