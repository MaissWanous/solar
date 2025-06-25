const express = require("express");
const router = express.Router();
const solarService = require("../service/solarService");

router.post('/solarSupplies', async (req, res) => {
  try {
   const {latitude, longitude,solarPanel,numNight,eDay,eNight,batteryType} = req.body;
   const response = await solarService.calculateSupplies(latitude, longitude,solarPanel,numNight,eDay,eNight,batteryType)
  
   res.status(200).json({ message: "Calculate supplies successfully.", data:response });
  } catch (err) {
    console.error("Error:", err);
    res.status(400).json({ error: err.message });
  }
});
router.post('/SolarPanelOrientation',async(req,res)=>{
  try {
   const {latitude, longitude} = req.body;
   const response = await solarService.getSolarPanelOrientation(latitude, longitude)
  
   res.status(200).json({  data:response });
  } catch (err) {
    console.error("Error:", err);
    res.status(400).json({ error: err.message });
  }
})

module.exports = router;
