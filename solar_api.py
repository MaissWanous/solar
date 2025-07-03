from fastapi import FastAPI
from pydantic import BaseModel, Field
from pvlib import location
import pandas as pd
from datetime import datetime
import pytz

app = FastAPI()

class SolarInput(BaseModel):
    latitude: float = Field(..., example=33.5138)  # Damascus
    longitude: float = Field(..., example=36.2765)
    efficiency: float = 0.20
    area: float = Field(..., example=1.6)
    system_losses: float = 0.25
    start_date: str = Field(..., example="2025-06-01")
    end_date: str = Field(..., example="2025-06-03")

@app.post("/estimate_energy")
def estimate_energy(data: SolarInput):
    try:
        start = datetime.strptime(data.start_date, "%Y-%m-%d")
        end = datetime.strptime(data.end_date, "%Y-%m-%d")

        if start > end:
            return {"error": "start_date must be before end_date"}

        damascus_tz = pytz.timezone("Asia/Damascus")
        times = pd.date_range(start=start, end=end + pd.Timedelta(days=1), freq='1h', tz=damascus_tz)

        site = location.Location(data.latitude, data.longitude, tz="Asia/Damascus")

        # Get clear sky irradiance (GHI, DNI, DHI)
        clearsky = site.get_clearsky(times)

        # Use GHI from clear sky
        ghi = clearsky['ghi'].fillna(0)

        # Calculate energy in kWh: GHI * efficiency * area * (1 - losses) integrated over time
        # Times are hourly, so sum gives Wh, divide by 1000 for kWh
        energy = (ghi * data.efficiency * data.area * (1 - data.system_losses)).sum() / 1000

        return {
            "estimated_energy_kWh": round(energy, 2),
            "start_date": data.start_date,
            "end_date": data.end_date,
            "location": {"lat": data.latitude, "lon": data.longitude}
        }

    except Exception as e:
        return {"error": str(e)}
