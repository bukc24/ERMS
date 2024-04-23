const express = require('express')
const router = express.Router()

//controller  functions
const {
    index,
    login,
    getUsers,
    newUser,

} = require("../controllers/erms")

 
//routes 
router.route('/').get(index)
//router.route('/login').get(login)
router.route('/users').get(getUsers).post(newUser)
router.route('/users/login').post(login)

module.exports= router