const router = require('express').Router();

const chatController = require("../controller/chat.controller");
    router.post('/', chatController.postChat);
module.exports = router;