const path = require('path')
const bcrypt = require('bcrypt')

const index = (req,res)=>{
        res.sendFile(path.join(__dirname,'..','public','index.html'));
}

// const login = (req,res)=>{
//     res.sendFile(path.join(__dirname,'..','public','login.html'));
// }

const users=[]
const getUsers = (req,res)=>{
    res.json(users);
}

const newUser = async (req,res)=>{
    const hashedPassword = await bcrypt.hash(req.body.password,10)



    const user = { name:req.body.name, password:hashedPassword}
    users.push(user)
    res.status(201).send()
}    


const login = async (req,res)=>{
    const user = users.find(user=>user.name = req.body.name)
    if (user ==null){
        return res.status(400).send("cannot find user")
    }
    try{
        if(await bcrypt.compare(req.body.password,user.password)){
            return res.send("allowed")

        }else{
            return res.send("not allowed")
        }
    }
    catch {
        res.status(500).send()
    }
}

module.exports ={
    index,
    login,
    getUsers,
    newUser
}