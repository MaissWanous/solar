const express = require('express');
const Sequelize = require('sequelize');
const fileUpload = require('express-fileupload');
const http = require('http');
const socketIo = require('socket.io');
const cors = require('cors');
const bodyParser = require('body-parser');
const path = require('path');
const db = require("./models");
const jwtService = require('./service/jwtService');
const chatService = require('./service/chatService');

const app = express();
const server = http.createServer(app);
const io = socketIo(server, {
  cors: {
    origin: "*",
    methods: ["GET", "POST"]
  }
});

// Middleware
app.use(cors());
app.use(fileUpload());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(express.json());
app.use("/uploads", express.static(path.join(__dirname, "public/uploads")));

// WebSocket logic
io.on('connection', (socket) => {
  console.log('User connected:', socket.id);

  socket.on('authenticate', (token) => {
    try {
      const user = jwtService.verifyToken(token);
      socket.userId = user.userId;
      socket.join(`user_${user.userId}`);
      console.log(`User ${user.userId} joined personal room.`);
    } catch (err) {
      console.log("Authentication failed:", err.message);
      socket.disconnect();
    }
  });

  socket.on('privateMessage', async ({ toUserId, message }) => {
    if (!socket.userId) {
      return socket.emit('error', 'Not authenticated');
    }

    try {
      // Save message to DB
      await chatService.saveMessage(socket.userId, toUserId, message);

      // Emit message to both users
      io.to(`user_${toUserId}`).emit('privateMessage', {
        fromUserId: socket.userId,
        message
      });

      io.to(`user_${socket.userId}`).emit('privateMessage', {
        fromUserId: socket.userId,
        message
      });
    } catch (err) {
      console.error("Message send error:", err);
      socket.emit('error', 'Message could not be sent');
    }
  });

  socket.on('disconnect', () => {
    console.log(`User disconnected: ${socket.userId}`);
  });
});

// API Routes
const userRoutes = require("./routes/user");
const productRoutes = require("./routes/products");
const chatRoutes = require("./routes/chat");
const solarRoutes =require("./routes/solar")

app.use("/", userRoutes);
app.use("/", productRoutes);
app.use("/", chatRoutes);
app.use("/",solarRoutes);

// Start server
db.sequelize.sync().then(() => {
  server.listen(4000, () => {
    console.log("Server is running on port 4000");
  });
}).catch((error) => {
  console.error("Error connecting to database:", error);
});
