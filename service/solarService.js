
const solarService = {
    async calculateSupplies(solarPanel, numNight, eDay, eNight, batteryType) {
        let transformDay = parseFloat(eDay) * 230;
        let numDay = 8;
        let dayLoad = numDay * transformDay;
        let numPanel = dayLoad / (parseInt(solarPanel) - parseInt(solarPanel) * 0.25);
        // inverter
        // volt = الفولط العاي للوح
        let volt=60;
        let cardPanel=450/volt;
        let possibility =transformDay+1000;
        if (cardPanel<numPanel) {
            possibility=8000;
        }
        let typeSystem;
        if (possibility<=2000&&possibility>=1200) {
            typeSystem=12;
        } else if(possibility<=6000&&possibility>=2500) {
            typeSystem=24;
        } else  {
            typeSystem=48;
        }
        // battary
         let transformNight = parseFloat(eNight) * 230;
         let nightLoad =transformNight *numNight;
        let possibilityBattary=nightLoad/nightLoad;
        let numBattery =1;
        if (batteryType==="tubular") {
            if (possibilityBattary<=100) {
                possibilityBattary=100
            } else if (possibilityBattary<=200) {
                possibilityBattary=200
            }else {
               possibilityBattary=230 
            }  
            numBattery=typeSystem/12; 
        }else {
              if (possibilityBattary<=100) {
                possibilityBattary=100
            }else if (possibilityBattary<=150) {
                possibilityBattary=150
            } 
            else if (possibilityBattary<=200) {
                possibilityBattary=200
            }else if(possibilityBattary<=250) {
               possibilityBattary=250 
            } else if(possibilityBattary<=280)
            {
                possibilityBattary=280
            }
            else possibilityBattary=300
        }
        
        let B =(possibilityBattary*typeSystem)/numDay;
         let numB = B/ (parseInt(solarPanel) - parseInt(solarPanel) * 0.25)
         numPanel+=numB;



         

    }
};

module.exports = solarService;
