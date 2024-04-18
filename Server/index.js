const app = require("./app");
const db = require('./config/db');
const UserModel = require('./model/user.model')
require("dotenv").config();

const PORT = process.env.SERVER_PORT;

app.get('/',(req, res)=>{
    res.send("hello world!!!!");
})

app.listen(PORT,()=>{
    console.log(`Server is listening on Port http://localhost:${PORT}`);
})