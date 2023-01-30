TriggerServerEvent('Prosper:checkip', 'BikeSpawner')

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

PHANS = {}
PHANS.Allow = true


if PHANS.Allow then

local Loc = vector3(-24.0863, -1829.2926, 25.6911)

RegisterNUICallback('spawnbike1', function()
    if ESX.Game.IsSpawnPointClear(Loc, 5.0) then
        SpawnVehicle('bmx')
    openBike(false)
    else
        TriggerEvent('esx:showNotification', 'this bike spawner is blocked')
        openBike(false)
    end
end)

RegisterNUICallback('close', function()
  openBike(false)
end)

function SpawnVehicle(model)
	ESX.Game.SpawnVehicle(model, Loc, 125.3145, function(vehicle)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
	end)
end

RegisterNUICallback('spawnbike2', function()
    if ESX.Game.IsSpawnPointClear(Loc, 5.0) then
        SpawnVehicle('sanchez') -----JUST CHANGNE THIS TO DIFF BIKE (HAVE 0 cars in server to test)
    openBike(false)
    else
        TriggerEvent('esx:showNotification', 'this bike spawner is blocked')
        openBike(false)
    end
end)

RegisterNUICallback('closemenu', function()
    openBike(false)
end)

function openBike(bool, info, blocked)
    if ESX.Game.IsSpawnPointClear(Loc, 5.0) then
        print('not')
        blocked = 'not blocked'
    else
        blocked = 'blocked'
    end
    display = bool
    SetNuiFocus(bool, bool)
SendNUIMessage({
    type = "bike_spawner",
    status = bool,
    checkblocked = blocked
})
end


local bikespawner = false
bikeConfig               = {}

bikeConfig.DrawDistance  = 5.0
bikeConfig.Size          = { x = 1.5, y = 1.5, z = 0.5 }
bikeConfig.Color         = { r = 255, g = 0, b = 0 }
bikeConfig.Type          = 1

bikeConfig.Zones = {
	BikeSpawner = {
		Locations = {
			vector3(-19.5615, -1824.3058, 24.7509),
            
		}
	},
}


local TextShown = false
local GetEntityCoords = GetEntityCoords
local CreateThread = CreateThread
local Wait = Wait
local IsControlJustReleased = IsControlJustReleased

-- Display markers
CreateThread(function()
    while true do
        local Sleep = 1500
        local InShop = false
        local CurrentShop = nil
        local coords = GetEntityCoords(PlayerPedId())

        for k, v in pairs(bikeConfig.Zones) do
            for i = 1, #v.Locations, 1 do
                if (bikeConfig.Type ~= -1 and #(coords - v.Locations[i]) < bikeConfig.DrawDistance) then
                    InShop = true
                    CurrentShop = v.Locations[i]
                    Sleep = 0
                    if #(coords - CurrentShop) < 2.0 then
                        if not TextShown then
                            TriggerEvent('esx:showNotification', 'Press [E] To Open Bike Spawner!')
                            TextShown = true
                        end
                        if IsControlJustReleased(0, 38) then
                            openBike(true)
                    end
                end
            end
                DrawMarker(bikeConfig.Type, v.Locations[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, bikeConfig.Size.x, bikeConfig.Size.y,
                    bikeConfig.Size.z, bikeConfig.Color.r, bikeConfig.Color.g, bikeConfig.Color.b, 100, false, true, 2, false, false,
                    false, false)
            end
        end
        if not CurrentShop and TextShown then
            TextShown = false
        end
        if not InShop and bikespawner then
            if bikespawner then
                TextShown = false
                ESX.CloseContext()
                bikespawner = false
            end
        end
        Wait(Sleep)
    end
end)
else
    print("set phans.allow = true so script works C: to give credits")
end