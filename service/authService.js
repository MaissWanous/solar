
const jwtService = require('./jwtService');
const userService = require('./userService');
async function login(email, password) {
    try {
        const user = await userService.login({ email, password });

        let token;
        if (user.user) {

            token = jwtService.generateToken({ userId: user.user.accountId });

            return ({ token: token, message: user.message })
        }
        return ({ token: 0, message: user.message });

    } catch (error) {
        console.log(error)
    }
}

async function refreshToken(user) {
    try {

        token = jwtService.generateToken({ userId: user });

        return ({ token: token, message: "ok" })
    } catch (error) {
        console.error("Error generating token:", error);
        return { token: null, message: "Failed to refresh token." };
    }
}


module.exports = { login, refreshToken };