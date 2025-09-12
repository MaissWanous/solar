const { io } = require("socket.io-client");

// Set these before testing
const token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsImlhdCI6MTc1NzY4MTIzMSwiZXhwIjoxNzU3NjkyMDMxfQ.po9m5DDKdXAjEv1tVO0hzDviWaEHaNpbhn0wkiV-j0Y";
const toUserId = 1; // Receiver's userId
const message = "Hii I'm user with id = 2";

const socket = io("http://localhost:4000", {
  transports: ["websocket"]
});

socket.on("connect", () => {
  console.log("✅ Connected to server");

  // Authenticate with JWT token
  socket.emit("authenticate", token);

  // Wait then send a message
  setTimeout(() => {
    console.log(`📤 Sending message to user ${toUserId}`);
    socket.emit("privateMessage", { toUserId, message });
  }, 1000);
});

socket.on("privateMessage", (data) => {
  console.log("📩 New message received:", data);
});

socket.on("disconnect", () => {
  console.log("❌ Disconnected");
});

socket.on("error", (err) => {
  console.error("❗ Error:", err);
});
