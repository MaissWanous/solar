const { io } = require("socket.io-client");

// Set these before testing
const token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjIsImlhdCI6MTc0OTk5NDUxN30.zf9nmfoJD7Rpz8oKvv-8v0jjDr1x1hjv1Hhqi0krZo4";
const toUserId = 4; // Receiver's userId
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
