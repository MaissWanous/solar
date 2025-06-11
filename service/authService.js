
const jwtService = require('./jwtService');
const userService = require('./userService');
async function login(email, password) {
    try {
        const user = await userService.checkLogIn({ email, password });
        console.log(user.message)
        let token;
        if (user.message != 0 && user.message != -1 && user.existingUser) {

            token = jwtService.generateToken({ userId: user.existingUser.ID });
            console.log(token+"uuuuuuuuuuuuuuuuuuuuuuuuuu")
            return ({ token: token, message: user.message })
        }
        console.log(token+"uuukkkkkkkkkkkkkkuuuuuuuu")
        return ({ token: 0, message: user.message });

    } catch (error) {
        console.log(error)
    }
}


module.exports = { login };