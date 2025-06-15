const express = require("express");
const router = express.Router();
const jwtService = require("../service/jwtService");
const chatService = require("../service/chatService");

router.get("/chat/:withUserId", async (req, res) => {
  const token = req.headers.authorization?.split(" ")[1];
  if (!token) return res.status(401).json({ error: "Token required." });

  try {
    const decoded = jwtService.verifyToken(token);
    const userId = decoded.userId;
    const withUserId = parseInt(req.params.withUserId);

    const messages = await chatService.getMessagesBetweenUsers(userId, withUserId);
    res.status(200).json({ messages });
  } catch (error) {
    console.error("Chat fetch error:", error);
    res.status(400).json({ error: "Invalid request." });
  }
});

module.exports = router;
