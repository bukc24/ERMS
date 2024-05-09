const express = require('express')
const path = require('path')
const erms = require('./routes/erms');
const bcrypt = require('bcrypt')
const cookieParser = require('cookie-parser');

require('dotenv').config({ path: '.env' });

const app = express();
const PORT = process.env.PORT || 3000;

//middleware
app.use(express.static('./public'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());


//router
app.use('/',erms)


//server
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});