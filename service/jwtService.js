const jwt = require('jsonwebtoken');
const config = require('../config/config.json');

class JwtService {
    generateToken(user) {
        const accessToken = jwt.sign(user, config.jwtSecret, { expiresIn: '3h' });

        const refreshToken = jwt.sign(user, config.jwtSecret, { expiresIn: '3m' });
        return { accessToken, refreshToken };
    }

    verifyToken(token) {
        try {
            return jwt.verify(token, config.jwtSecret);
        } catch (error) {
            if (error instanceof jwt.TokenExpiredError) {
                throw new Error('Token has expired');
            } else {
                throw new Error('Invalid token');
            }
        }
    }
}

module.exports = new JwtService();