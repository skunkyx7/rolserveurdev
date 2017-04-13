local plyPed = GetPlayerPed(-1)
local plyVeh = GetVehiclePedIsUsing(GetPlayerPed(-1))
local shortR = true

-----------------------------------------------------------------------
----------------------------CARWASH-LOCATION----------------------------
-----------------------------------------------------------------------

vehicleRepairStation = {
	{26.5906,  -1392.0261,  27.3634},
	{167.1034,  -1719.4704,  27.2916},
	{-74.5693,  6427.8715,  29.4400},
	{-699.6325,  -932.7043,  17.0139}
}

	
Citizen.CreateThread(function ()
	Citizen.Wait(0)
	for i = 1, #vehicleRepairStation do
		garageCoords = vehicleRepairStation[i]
		stationBlip = AddBlipForCoord(garageCoords[1], garageCoords[2], garageCoords[3])
		SetBlipSprite(stationBlip, 100) --100 = carwash
		SetBlipAsShortRange(stationBlip, true)
	end
    return
end)

function DrawSpecialText(m_text, showtime)
    ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
			for i = 1, #vehicleRepairStation do
				garageCoords2 = vehicleRepairStation[i]
				DrawMarker(1, garageCoords2[1], garageCoords2[2], garageCoords2[3], 0, 0, 0, 0, 0, 0, 5.0, 5.0, 2.0, 0, 157, 0, 155, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), garageCoords2[1], garageCoords2[2], garageCoords2[3], true ) < 5 then 
					SetVehicleDirtLevel(GetVehiclePedIsUsing(GetPlayerPed(-1)))
					SetVehicleUndriveable(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
					DrawSpecialText("Vehicle ~h~~y~Clean~w~ NO COST FOR NOW!!!!", 5000)
				end
			end
		end
	end
end)