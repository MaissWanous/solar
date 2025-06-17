const express = require("express");
const router = express.Router();
const solarService = require("../service/solarService");

router.post('/solarSupplies', async (req, res) => {
  try {
   const {solarPanel,numNight,eDay,eNight,batteryType} = req.body;
   const response = solarService.calculateSupplies(solarPanel,numNight,eDay,eNight,batteryType)
    res.status(200).json({ message: "Product picture uploaded successfully.", path: dbPath });
  } catch (err) {
    console.error("Error:", err);
    res.status(400).json({ error: err.message });
  }
});

module.exports = router;
