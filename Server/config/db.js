const mongoose = require('mongoose');
require("dotenv").config();

const MONGO_DB_URL = process.env.MONGO_DB_URL;

const connection = mongoose.createConnection(MONGO_DB_URL).on('open',()=>{
    console.log("mongodb connected");
}).on('error', (error)=>{
    console.log(error);
});

module.exports = connection;