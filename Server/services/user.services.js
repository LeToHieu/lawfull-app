const UserModel = require('../model/user.model');
const jwt = require("jsonwebtoken");

class UserServices {
    static async registerUser(email, username, password) {
        try {
            // Check if the email already exists in the database
            const existingUser = await UserModel.findOne({ email });
            if (existingUser) {
                return { error: "Email already exists" }; // Return an error message if email is already registered
            }

            // If email is not found, proceed with user registration
            const createUser = new UserModel({ email, username, password });
            return await createUser.save();
        } catch (err) {
            console.log(`There is some error at UserService\n${err}`);
            return { error: "There something wrong with db" };
        }
    }

    static async checkUser(email){
        try{
            const user =  await UserModel.findOne({email});
            if(!user){
                return { error: "User don't exists" }; 
            }else{
                return user;
            }
        }catch(error){
            console.log(`There is some error at UserService\n${err}`);
            return { error: "There something wrong with db" };
        }
    }

    static async generateToken(tokenData, secreteKey, jwt_expire){
        return jwt.sign(tokenData, secreteKey, {expiresIn: jwt_expire});
    }
}

module.exports = UserServices;
