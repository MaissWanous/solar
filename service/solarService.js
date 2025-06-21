
const solarService = {
    async calculateSupplies(solarPanel, numNight, eDay, eNight, batteryType) {
        let transformDay = parseInt(eDay) * 230;
        let numDay = 8;
        let dayLoad = numDay * transformDay;
        let numPanel = dayLoad / (parseInt(solarPanel) - parseInt(solarPanel) * 0.25);
        let volt=60;
        let cardPanel=450/volt;
    }
};

module.exports = solarService;
