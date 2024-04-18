const UserService = require("../services/user.services");
require("dotenv").config();
const JWT_SECRET_KEY = process.env.JWT_SECRET_KEY;
exports.register = async (req, res, next) => {
    try {
        const { email, username, password } = req.body;

        const result = await UserService.registerUser(email, username, password);
        if (result.error) {
            // If there is an error message returned from the service, send it as response
            res.status(400).json({
                status: false,
                message: result.error
            });
        } else {
            // If registration is successful, send success response
            res.status(200).json({
                status: true,
                message: "User Registered Successfully"
            });
        }
    } catch (err) {
        console.error(err);
        res.status(500).json({
            status: false,
            message: "Internal Server Error"
        });
    }
}


exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;

        const user = await UserService.checkUser(email);
        if (user.error) {
            // If there is an error message returned from the service, send it as response
            res.status(400).json({
                status: false,
                message: user.error
            });
            return;
        }
        const isMatch = await user.comparePassword(password);
        if(isMatch === false){
            res.status(400).json({
                status: false,
                message: "wrong email or password"
            });
         }else{
            let tokenData = {_id:user._id,username: user.username, email:user.email};

            const token = await UserService.generateToken(tokenData, JWT_SECRET_KEY, "1d")
            res.status(200).json({
                status: true,
                token: token,
                message: "User Login Successfully"
            });
         }
    } catch (err) {
        console.error(err);
        res.status(500).json({
            status: false,
            message: "Internal Server Error"
        });
    }
}
