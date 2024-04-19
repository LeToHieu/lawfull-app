const {textRender} = require('../ai_hander/lib/chat')


exports.postChat = async (req, res, next) => {
    try {
        const { msg } = req.body;
        const chatData = await textRender(msg);
      
        console.log(chatData);
        res.status(200).json({
             status: true,
             data: chatData,
             message: "Recive ChuDe successfully"
         });
    } catch (err) {
        console.error(err);
        res.status(500).json({
            status: false,
            message: "Internal Server Error"
        });
    }
}