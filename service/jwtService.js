const jwt = require('jsonwebtoken');
const config = require('../config/config.json');

class JwtService {
    generateToken(user) {
        return jwt.sign(user, config.jwtSecret);
    }

    verifyToken(token) {
        return jwt.verify(token, config.jwtSecret);
    }
}

module.exports = new JwtService();