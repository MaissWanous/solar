const { inverter, products, shop, battery, solar_panel } = require("../models");
const SunCalc = require('suncalc');

const solarService = {
  async calculateSupplies(latitude, longitude, solarPanel, numNight, eDay, eNight, batteryType) {
    // Convert daytime energy usage (kWh) to watt-hours (Wh)
    const transformDay = parseFloat(eDay) * 230;
    const date = new Date("2024-12-08");
    const times = SunCalc.getTimes(date, latitude, longitude);

    const numDay = (times.sunset - times.sunrise) / (1000 * 60 * 60); // in hours
    const dayLoad = numDay * transformDay;

    // Adjust panel output for 25% loss
    const panelOutput = parseInt(solarPanel) * 0.75;
    let numPanel = dayLoad / panelOutput;

    // Estimate inverter power requirement
    const volt = 60;
    const cardPanel = 450 / volt;
    let possibility = transformDay + 1000;

    if (cardPanel < numPanel) possibility = 8000;

    // Determine system voltage
    let typeSystem;
    if (possibility >= 1200 && possibility <= 2000) {
      typeSystem = 12;
    } else if (possibility >= 2500 && possibility <= 6000) {
      typeSystem = 24;
    } else {
      typeSystem = 48;
    }

    // Convert nighttime energy usage (kWh) to watt-hours
    const transformNight = parseFloat(eNight) * 230;
    const nightLoad = transformNight * numNight;

    // Estimate battery size (placeholder logic assumes 100% use)
    let possibilityBattery = nightLoad;

    // Determine battery capacity
    let batteryCapacity;
    let numBattery;
    if (batteryType === "tubular") {
      batteryCapacity = possibilityBattery <= 100 ? 100 :
                        possibilityBattery <= 200 ? 200 : 230;
      numBattery = typeSystem / 12;
    } else {
      batteryCapacity = possibilityBattery <= 100 ? 100 :
                        possibilityBattery <= 150 ? 150 :
                        possibilityBattery <= 200 ? 200 :
                        possibilityBattery <= 250 ? 250 :
                        possibilityBattery <= 280 ? 280 : 300;
      numBattery = 1;
    }

    // Additional panels required to charge batteries
    const batteryWattHours = (batteryCapacity * typeSystem);
    const batteryLoadPerDay = batteryWattHours / numDay;
    const extraPanels = batteryLoadPerDay / panelOutput;

    numPanel += extraPanels;

    // Fetch related products
    const inverters = await inverter.findAll({
      where: { inverterRatingP: possibility },
      include: [{
        model: products,
        include: [{ model: shop }]
      }]
    });

    const batteries = await battery.findAll({
      where: {
        batteryType: batteryType,
        batterySize: batteryCapacity
      },
      include: [{
        model: products,
        include: [{ model: shop }]
      }]
    });

    const solarPanels = await solar_panel.findAll({
      where: { maximumPower: solarPanel },
      include: [{
        model: products,
        include: [{ model: shop }]
      }]
    });

    // Return results
    return {
      solarPanel: solarPanel,
      numPanel: Math.ceil(numPanel),
      Battery: batteryCapacity,
      inverter: possibility,
      batteryNum: numBattery,
      products: {
        inverters,
        batteries,
        solarPanels
      }
    };
  },
  async  getSolarPanelOrientation(latitude, longitude) {
      // Basic rule: tilt ≈ latitude
    const tilt = Math.floor(Math.abs(latitude)); 


    // Azimuth: South-facing in Northern hemisphere, North-facing in Southern
    const azimuth = latitude >= 0 ? "South" : "North";

    return {
        azimuth: azimuth,     // In degrees: 0 = North, 180 = South
        tilt: tilt            // In degrees from horizontal
    };
  }

};

module.exports = solarService;
