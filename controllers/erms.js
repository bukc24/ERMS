const path = require('path')


const index = (req,res)=>{
        res.sendFile(path.join(__dirname,'..','public','index.html'));
}

const login = (req,res)=>{
    res.sendFile(path.join(__dirname,'..','public','login.html'));
}

module.exports ={
    index,
    login
}