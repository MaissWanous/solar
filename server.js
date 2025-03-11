const express = require('express');
const Sequelize = require('sequelize');
const fileUpload = require('express-fileupload');
const cors = require('cors');
const bodyParser = require('body-parser');
const db = require("./models");
const app = express()
// Set up middleware
app.use(cors());
app.use(fileUpload());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(express.json());

// API routes
const userRout = require("./routes/user");
app.use("/", userRout);


// Establish database connection 
db.sequelize.sync().then(() => {
    app.listen(4000, () => {
        console.log("Server is running on port 3000");
    });
})
    .catch((error) => {
        console.error("Error connecting to database:", error);
    });