const express = require('express');
const body_parser = require('body-parser');
const userRouter = require("./routers/user.route");
const phapDien = require("./routers/phapdien.route");
const chatRoute = require("./routers/chat.route");
const app = express();

app.use(body_parser.json());
app.use('/', userRouter);
app.use('/',phapDien);
app.use('/chat',chatRoute);

module.exports = app;