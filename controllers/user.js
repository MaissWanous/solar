const express = require('express');
const router = express.Router();
const userService = require('../service/userService');

router.post('/signup', async (req, res) => {
  try {
    const newUser = await userService.createUser(req.body);
    res.redirect('/signup/success');
  } catch (error) {
    console.error(error);
    res.status(500).send('حدث خطأ أثناء التسجيل');
  }
});

module.exports = router;