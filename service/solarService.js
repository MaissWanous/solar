const { inverter, products, shop, battery, solar_panel } = require("../models");
const SunCalc = require('suncalc');

const solarService = {
  async calculateSupplies(latitude, longitude, solarPanel, numNight, eDay, eNight, batteryType) {
    // Convert daytime energy usage (kWh) to watt-hours (Wh)
    const transformDay = parseFloat(eDay) * 230;
    const date = new Date("2024-12-08");
    const times = SunCalc.getTimes(date, latitude, longitude);
    let numDay = (times.sunset - times.sunrise) / (1000 * 60 * 60);
    numDay = parseInt(numDay / 2);
    const dayLoad = transformDay;

    // Adjust panel output for 25% loss
    const panelOutput = parseInt(solarPanel) * 0.75;
    let numPanel = Math.round(dayLoad / panelOutput);

    // Estimate inverter power requirement
    let volt;
    volt =
      solarPanel == 425 ? 40.3 :
        solarPanel == 450 ? 41 :
          solarPanel == 545 ? 42 :
            solarPanel == 585 ? 44 :
              solarPanel == 600 ? 49 :
                solarPanel == 615 ? 50.2 :
                  solarPanel == 700 ? 51 : 51.5
    const cardPanel = 450 / volt;
    const options = [1200, 2000, 2500, 6000];

    let possibility = options.find(val => val >= transformDay);

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
    const transformNight = parseInt(eNight) * 230;
    const nightLoad = transformNight * numNight;

    // Estimate battery size (placeholder logic assumes 100% use)
    let possibilityBattery = nightLoad / typeSystem;

    // Determine battery capacity
    let batteryCapacity;
    let numBattery = 1;
    if (batteryType === "tubular") {
      const gelBatteryLevels = [100, 200, 230, 250, 300];
      possibilityBattery *= 2;

      numBattery = 1;
      let singleCapacity = possibilityBattery;

      while (!gelBatteryLevels.includes(singleCapacity) && singleCapacity > Math.max(...gelBatteryLevels)) {
        numBattery++;
        singleCapacity = Math.ceil(possibilityBattery / numBattery);
      }

      // إذا ما لقينا قيمة مطابقة، نختار أقرب قيمة أكبر أو مساوية
      batteryCapacity = gelBatteryLevels.find(level => level >= singleCapacity);

      // إذا ما لقينا شيء، نختار أكبر قيمة ممكنة
      if (!batteryCapacity) {
        batteryCapacity = Math.max(...gelBatteryLevels.filter(val => val <= singleCapacity));
      }




    } else {
      const levels = [100, 150, 200, 250, 280, 300, 320, 350, 500, 600];

      batteryCapacity = levels.find(level => level >= possibilityBattery);


      if (!batteryCapacity) {
        batteryCapacity = 600;
      }

      numBattery = 1;
    }
    console.log(numDay)
    // Additional panels required to charge batteries
    const batteryWattHours = (batteryCapacity * typeSystem);
    const batteryLoadPerDay = (batteryWattHours / numDay) * 0.75;
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
    let mppt=possibility<8000?60:90;

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
      numPanel: Math.round(numPanel),
      Battery: batteryCapacity,
      inverter: possibility,
      batteryNum: numBattery,
      solarChMod:possibility,
      mppt:mppt,
      products: {
        inverters,
        batteries,
        solarPanels
      }
    };
  },
  async getSolarPanelOrientation(latitude, longitude) {
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
