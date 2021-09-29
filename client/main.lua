Keys = {
	['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
	['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
	['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
	['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
	['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
	['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
	['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
	['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

QBCore = nil

local CurrentCopsOnly = 0
local ShouldCallPolice = false
local plate = nil

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(1)
        if QBCore == nil then
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end) 
            Citizen.Wait(200)
        end
    end
end)
-----------------------------------
---------- Locais de spawn---------
-----------------------------------
local CarSpawn1  = vector3(-318.87478637695,-931.12158203125,30.401069641113)
local CarSpawn2  = vector3(-291.35000610352,-1021.4533081055,29.705415725708)
local CarSpawn3  = vector3(50.464317321777,-873.74267578125,29.75079536438)
local CarSpawn4  = vector3(138.11235046387,-1069.3375244141,28.513885498047)
local CarSpawn5  = vector3(214.30224609375,-940.23962402344,23.462652206421)

local CarSpawn6 = vector3(450.36791992188,-996.88928222656,25.086135864258)
local CarSpawn7 = vector3(474.69989013672,-900.54730224609,35.292850494385)
local CarSpawn8 = vector3(383.99996948242,-739.23669433594,28.614965438843)
local CarSpawn9 = vector3(450.36791992188,-996.88928222656,25.086135864258)

local entrega1  = vector3(-1110.4777832031,-1240.5659179688,1.7450875043869)
local entrega2  = vector3(3333.7790527344,5161.3461914062,17.612237930298)
local entrega3  = vector3(1564.2204589844,3573.5993652344,33.000503540039)
-----------------------------------
------- Verificação da policia ----
-----------------------------------
RegisterNetEvent('police:SetCopCount')
AddEventHandler('police:SetCopCount', function(amount)
    CurrentCopsOnly = amount
end)
-----------------------------------
---------- evento do olho ---------
-----------------------------------
RegisterNetEvent("qb-car:cl:hack")
AddEventHandler("qb-car:cl:hack",function()
    if CurrentCopsOnly >= 1 then
        TriggerServerEvent("qb-car:sv:pendrive")
    else
        QBCore.Functions.Notify("Não há policiais suficientes", "error")
    end
end)
-----------------------------------
--------- Evento do hack ----------
-----------------------------------
RegisterNetEvent("qb-car:cl:green")
AddEventHandler("qb-car:cl:green",function()
    TriggerEvent("utk_fingerprint:Start", 4, 6, 2, function(outcome, reason)
        if outcome == true then 
            QBCore.Functions.Notify("O sistema foi invadido", "success")
            TriggerServerEvent("qb-car:additem:green")
            TriggerServerEvent('XP:Hud:Server:GainStress', math.random(1, 3))
            spawncargreen()
            local chance = math.random(1, 100)
            if chance <= 40 then
                TriggerEvent("police-dispatch:PDMRobbery")
            end
        elseif outcome == false then
            QBCore.Functions.Notify("Será que o Indiano melhorou o sistema?", "error")
            TriggerServerEvent('XP:Hud:Server:GainStress', math.random(1, 3))
            TriggerEvent("police-dispatch:PDMRobbery")
        end
    end)
end)

RegisterNetEvent("qb-car:cl:red")
AddEventHandler("qb-car:cl:red",function()
    TriggerEvent("utk_fingerprint:Start", 4, 6, 2, function(outcome, reason)
        if outcome == true then 
            QBCore.Functions.Notify("O sistema foi invadido", "success")
            TriggerServerEvent("qb-car:additem:red")
            TriggerServerEvent('XP:Hud:Server:GainStress', math.random(1, 4))
            spawncarred()
            local chance = math.random(1, 100)
            if chance <= 60 then
                TriggerEvent("police-dispatch:PDMRobbery")
            end
        elseif outcome == false then
            QBCore.Functions.Notify("Será que o Indiano melhorou o sistema?", "error")
            TriggerServerEvent('XP:Hud:Server:GainStress', math.random(1, 4))
            TriggerEvent("police-dispatch:PDMRobbery")
        end
    end)
end)

RegisterNetEvent("qb-car:cl:yellow")
AddEventHandler("qb-car:cl:yellow",function()
    TriggerEvent("utk_fingerprint:Start", 4, 6, 2, function(outcome, reason)
        if outcome == true then
            QBCore.Functions.Notify("O sistema foi invadido", "success")
            TriggerServerEvent("qb-car:additem:yellow")
            TriggerServerEvent('XP:Hud:Server:GainStress', math.random(1, 5))
            spawncaryellow()
            TriggerEvent("police-dispatch:PDMRobbery")
        elseif outcome == false then
            QBCore.Functions.Notify("Será que o Indiano melhorou o sistema?", "error")
            TriggerServerEvent('XP:Hud:Server:GainStress', math.random(1, 5))
            TriggerEvent("police-dispatch:PDMRobbery")
        end
    end)
end)
-----------------------------------
---------- Progress Bar -----------
-----------------------------------
RegisterNetEvent("qb-car:cl:progressbar")
AddEventHandler("qb-car:cl:progressbar", function()
    QBCore.Functions.Progressbar("coke_destroy", "Estabelecendo Conexão", 10000, false, false, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@gangops@facility@servers@",
        anim = "anim@heists@prison_heiststation@cop_reactions",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(GetPlayerPed(-1), "anim@gangops@facility@servers@", "anim@heists@prison_heiststation@cop_reactions", 1.0)
        isDoingAction = false
        ClearPedTasksImmediately(ped)
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "anim@gangops@facility@servers@", "anim@heists@prison_heiststation@cop_reactions", 1.0)
        QBCore.Functions.Notify("Cancelado", "error")
    end)
end)
-----------------------------------
----- Evento de ligar o carro -----
-----------------------------------
RegisterNetEvent('qb-car:chave:green')
AddEventHandler('qb-car:chave:green', function()
    local ped = GetPlayerPed(-1)
    local inVehicle = IsPedInAnyVehicle(ped)
    if inVehicle then
        if plate ~= nil and string.find(GetVehicleNumberPlateText(GetVehiclePedIsIn(ped)), plate) ~= nil then
            QBCore.Functions.Progressbar("connect_laptop", "Conectando", 2000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                flags = 16,
            }, {}, {}, function() -- Done
                StopAnimTask(GetPlayerPed(-1), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(GetVehiclePedIsIn(ped)))
                QBCore.Functions.Notify("Você receberá o local para entregar o veículo", "success")
                TriggerEvent('robberycar:server:callCops1')
                greencar()
                RemoveBlip(spawncar)
            end, function() -- Cancel
                StopAnimTask(GetPlayerPed(-1), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                QBCore.Functions.Notify("Cancelado", "error")
            end)
        else
            QBCore.Functions.Notify("Você não pode fazer isso nesse veículo", "error")
            TriggerServerEvent("qb-car:additem:green")
        end
    else
        QBCore.Functions.Notify("Você não está em um veículo", "error")
        TriggerServerEvent("qb-car:additem:green")
    end
end)

RegisterNetEvent('qb-car:chave:red')
AddEventHandler('qb-car:chave:red', function()
    local ped = GetPlayerPed(-1)
    local inVehicle = IsPedInAnyVehicle(ped)
    if inVehicle then
        if plate ~= nil and string.find(GetVehicleNumberPlateText(GetVehiclePedIsIn(ped)), plate) ~= nil then
            QBCore.Functions.Progressbar("connect_laptop", "Conectando", 2000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                flags = 16,
            }, {}, {}, function() -- Done
                StopAnimTask(GetPlayerPed(-1), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(GetVehiclePedIsIn(ped)))
                QBCore.Functions.Notify("Você receberá o local para entregar o veículo", "success")
                TriggerEvent('robberycar:server:callCops1')
                redcar()
                RemoveBlip(spawncar)
            end, function() -- Cancel
                StopAnimTask(GetPlayerPed(-1), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                QBCore.Functions.Notify("Cancelado", "error")
            end)
        else
            QBCore.Functions.Notify("Esse veículo não é válido para isso", "error")
            TriggerServerEvent("qb-car:additem:red")
        end
    else
        QBCore.Functions.Notify("Você não está em um veículo", "error")
        TriggerServerEvent("qb-car:additem:red")
    end
end)

RegisterNetEvent('qb-car:chave:yellow')
AddEventHandler('qb-car:chave:yellow', function()
    local ped = GetPlayerPed(-1)
    local inVehicle = IsPedInAnyVehicle(ped)
    if inVehicle then
        if plate ~= nil and string.find(GetVehicleNumberPlateText(GetVehiclePedIsIn(ped)), plate) ~= nil then
            QBCore.Functions.Progressbar("connect_laptop", "Conectando", 2000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                anim = "machinic_loop_mechandplayer",
                flags = 16,
            }, {}, {}, function() -- Done
                StopAnimTask(GetPlayerPed(-1), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(GetVehiclePedIsIn(ped)))
                TriggerEvent('robberycar:server:callCops1')
                yellowcar()
                RemoveBlip(spawncar)
                QBCore.Functions.Notify("Você receberá o local para entregar o veículo", "success")
            end, function() -- Cancel
                StopAnimTask(GetPlayerPed(-1), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
                QBCore.Functions.Notify("Cancelado", "error")
            end)
        else
            QBCore.Functions.Notify("Esse veículo não é válido para isso", "error")
            TriggerServerEvent("qb-car:additem:yellow")
        end
    else
        QBCore.Functions.Notify("Você não está em um veículo", "error")
    end
end)
------------------------------------
-------- Spawna os veiculos---------
------------------------------------
function spawncargreen()
    Citizen.CreateThread(function()
        local DrawCoord = math.random(1, 5)
            if DrawCoord == 1 then
                CarLocation = CarSpawn1
            elseif DrawCoord == 2 then
                CarLocation = CarSpawn2
            elseif DrawCoord == 3 then
                CarLocation = CarSpawn3
            elseif DrawCoord == 4 then
                CarLocation = CarSpawn4
            elseif DrawCoord == 5 then
                CarLocation = CarSpawn5
        end           
        local spawn = math.random(1, 21)
        plate = tostring("PDM"..math.random(1000, 9999))
            if spawn == 1 then
                RequestModel(GetHashKey('yosemite3'))
                while not HasModelLoaded(GetHashKey('yosemite3')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('yosemite3'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)  
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            elseif spawn == 2 then
                RequestModel(GetHashKey('blista2'))
                while not HasModelLoaded(GetHashKey('blista2')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('blista2'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)      
            elseif spawn == 3 then
                RequestModel(GetHashKey('t20'))
                while not HasModelLoaded(GetHashKey('t20')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('t20'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)  
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)  
            elseif spawn == 4 then
                RequestModel(GetHashKey('ingot'))
                while not HasModelLoaded(GetHashKey('ingot')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('ingot'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 5 then
                RequestModel(GetHashKey('osiris'))
                while not HasModelLoaded(GetHashKey('osiris')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('osiris'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)    
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            elseif spawn == 6 then
                RequestModel(GetHashKey('stanier'))
                while not HasModelLoaded(GetHashKey('stanier')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('stanier'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 7 then
                RequestModel(GetHashKey('zentorno'))
                while not HasModelLoaded(GetHashKey('zentorno')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('zentorno'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 8 then
                RequestModel(GetHashKey('issi2'))
                while not HasModelLoaded(GetHashKey('issi2')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('issi2'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true) 
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)   
            elseif spawn == 9 then
                RequestModel(GetHashKey('panto'))
                while not HasModelLoaded(GetHashKey('panto')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('panto'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)    
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            elseif spawn == 10 then
                RequestModel(GetHashKey('ninef'))
                while not HasModelLoaded(GetHashKey('ninef')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('ninef'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)    
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            elseif spawn == 11 then
                RequestModel(GetHashKey('baller'))
                while not HasModelLoaded(GetHashKey('baller')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('baller'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 12 then
                RequestModel(GetHashKey('ninef2'))
                while not HasModelLoaded(GetHashKey('ninef2')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('ninef2'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 13 then
                RequestModel(GetHashKey('habanero'))
                while not HasModelLoaded(GetHashKey('habanero')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('habanero'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 14 then
                RequestModel(GetHashKey('youga3'))
                while not HasModelLoaded(GetHashKey('youga3')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('youga3'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)    
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            elseif spawn == 15 then
                RequestModel(GetHashKey('minivan'))
                while not HasModelLoaded(GetHashKey('minivan')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('minivan'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)  
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)  
            elseif spawn == 16 then
                RequestModel(GetHashKey('speedo'))
                while not HasModelLoaded(GetHashKey('speedo')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('speedo'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)    
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            elseif spawn == 17 then
                RequestModel(GetHashKey('bestiagts'))
                while not HasModelLoaded(GetHashKey('bestiagts')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('bestiagts'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 18 then
                RequestModel(GetHashKey('tornado'))
                while not HasModelLoaded(GetHashKey('tornado')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('tornado'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true) 
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)   
            elseif spawn == 19 then
                RequestModel(GetHashKey('carbonizzare'))
                while not HasModelLoaded(GetHashKey('carbonizzare')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('carbonizzare'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)    
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            elseif spawn == 20 then
                RequestModel(GetHashKey('comet2'))
                while not HasModelLoaded(GetHashKey('comet2')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('comet2'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 21 then
                RequestModel(GetHashKey('rebel2'))
                while not HasModelLoaded(GetHashKey('rebel2')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('rebel2'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)    
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            end
        QBCore.Functions.Notify("Localização recebida", "success")
    end)
end

function spawncarred()
    Citizen.CreateThread(function()
        local DrawCoord = math.random(1, 5)
            if DrawCoord == 1 then
                CarLocation = CarSpawn1
            elseif DrawCoord == 2 then
                CarLocation = CarSpawn2
            elseif DrawCoord == 3 then
                CarLocation = CarSpawn3
            elseif DrawCoord == 4 then
                CarLocation = CarSpawn4
            elseif DrawCoord == 5 then
                CarLocation = CarSpawn5
            end          
        local spawn = math.random(1, 11)
        plate = tostring("PDM"..math.random(1000, 9999))
            if spawn == 1 then
                RequestModel(GetHashKey('turismor'))
                while not HasModelLoaded(GetHashKey('turismor')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('turismor'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)  
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            elseif spawn == 2 then
                RequestModel(GetHashKey('penumbra2'))
                while not HasModelLoaded(GetHashKey('penumbra2')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('penumbra2'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)  
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)       
            elseif spawn == 3 then
                RequestModel(GetHashKey('banshee'))
                while not HasModelLoaded(GetHashKey('banshee')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('banshee'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)  
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)  
            elseif spawn == 4 then
                RequestModel(GetHashKey('coquette'))
                while not HasModelLoaded(GetHashKey('coquette')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('coquette'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)  
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)  
            elseif spawn == 5 then
                RequestModel(GetHashKey('drafter'))
                while not HasModelLoaded(GetHashKey('drafter')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('drafter'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 6 then
                RequestModel(GetHashKey('alpha'))
                while not HasModelLoaded(GetHashKey('alpha')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('alpha'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)  
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)  
            elseif spawn == 7 then
                RequestModel(GetHashKey('jester3'))
                while not HasModelLoaded(GetHashKey('jester3')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('jester3'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)    
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            elseif spawn == 8 then
                RequestModel(GetHashKey('kanjo'))
                while not HasModelLoaded(GetHashKey('kanjo')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('kanjo'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)    
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            elseif spawn == 9 then
                RequestModel(GetHashKey('furoregt'))
                while not HasModelLoaded(GetHashKey('furoregt')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('furoregt'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 10 then
                RequestModel(GetHashKey('massacro'))
                while not HasModelLoaded(GetHashKey('massacro')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('massacro'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)    
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            elseif spawn == 11 then
                RequestModel(GetHashKey('massacro'))
                while not HasModelLoaded(GetHashKey('massacro')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('massacro'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)    
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            end
        QBCore.Functions.Notify("Localização recebida", "success")
    end)
end

function spawncaryellow()
    Citizen.CreateThread(function()
        local DrawCoord = math.random(1, 4)
            if DrawCoord == 1 then
                CarLocation = CarSpawn6
            elseif DrawCoord == 2 then
                CarLocation = CarSpawn7
            elseif DrawCoord == 3 then
                CarLocation = CarSpawn8
            elseif DrawCoord == 4 then
                CarLocation = CarSpawn9
            end        

        local spawn = math.random(1, 31)
        plate = tostring("PDM"..math.random(1000, 9999))
            if spawn == 1 then
                RequestModel(GetHashKey('r35'))
                while not HasModelLoaded(GetHashKey('r35')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('r35'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)  
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            elseif spawn == 2 then
                RequestModel(GetHashKey('gtrc'))
                while not HasModelLoaded(GetHashKey('gtrc')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('gtrc'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)         
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 3 then
                RequestModel(GetHashKey('italirsx'))
                while not HasModelLoaded(GetHashKey('italirsx')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('italirsx'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true) 
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)   
            elseif spawn == 4 then
                RequestModel(GetHashKey('por930'))
                while not HasModelLoaded(GetHashKey('por930')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('por930'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 5 then
                RequestModel(GetHashKey('schlagen'))
                while not HasModelLoaded(GetHashKey('schlagen')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('schlagen'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)  
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)  
            elseif spawn == 6 then
                RequestModel(GetHashKey('r8v10'))
                while not HasModelLoaded(GetHashKey('r8v10')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('r8v10'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 7 then
                RequestModel(GetHashKey('pariah'))
                while not HasModelLoaded(GetHashKey('pariah')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('pariah'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true) 
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)   
            elseif spawn == 8 then
                RequestModel(GetHashKey('mustang19'))
                while not HasModelLoaded(GetHashKey('mustang19')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('mustang19'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 9 then
                RequestModel(GetHashKey('lynx'))
                while not HasModelLoaded(GetHashKey('lynx')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('lynx'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 10 then
                RequestModel(GetHashKey('locust'))
                while not HasModelLoaded(GetHashKey('locust')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('locust'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 11 then
                RequestModel(GetHashKey('skyline'))
                while not HasModelLoaded(GetHashKey('skyline')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('skyline'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 12 then
                RequestModel(GetHashKey('lwgtr'))
                while not HasModelLoaded(GetHashKey('lwgtr')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('lwgtr'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 13 then
                RequestModel(GetHashKey('rapidgt'))
                while not HasModelLoaded(GetHashKey('rapidgt')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('rapidgt'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 14 then
                RequestModel(GetHashKey('f620'))
                while not HasModelLoaded(GetHashKey('f620')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('f620'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 15 then
                RequestModel(GetHashKey('ellie'))
                while not HasModelLoaded(GetHashKey('ellie')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('ellie'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 16 then
                RequestModel(GetHashKey('dominator'))
                while not HasModelLoaded(GetHashKey('dominator')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('dominator'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 17 then
                RequestModel(GetHashKey('dominator3'))
                while not HasModelLoaded(GetHashKey('dominator3')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('dominator3'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 18 then
                RequestModel(GetHashKey('tigon'))
                while not HasModelLoaded(GetHashKey('tigon')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('tigon'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 19 then
                RequestModel(GetHashKey('coquette4'))
                while not HasModelLoaded(GetHashKey('coquette4')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('coquette4'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 20 then
                RequestModel(GetHashKey('gauntlet5'))
                while not HasModelLoaded(GetHashKey('gauntlet5')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('gauntlet5'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 21 then
                RequestModel(GetHashKey('69charger'))
                while not HasModelLoaded(GetHashKey('69charger')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('69charger'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 21 then
                RequestModel(GetHashKey('elegy'))
                while not HasModelLoaded(GetHashKey('elegy')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('elegy'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 22 then
                RequestModel(GetHashKey('banshee2'))
                while not HasModelLoaded(GetHashKey('banshee2')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('banshee2'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0) 
            elseif spawn == 23 then
                RequestModel(GetHashKey('gauntlet3'))
                while not HasModelLoaded(GetHashKey('gauntlet3')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('gauntlet3'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            elseif spawn == 24 then
                RequestModel(GetHashKey('gauntlet4'))
                while not HasModelLoaded(GetHashKey('gauntlet4')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('gauntlet4'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            elseif spawn == 25 then
                RequestModel(GetHashKey('acs8'))
                while not HasModelLoaded(GetHashKey('acs8')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('acs8'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            elseif spawn == 26 then
                RequestModel(GetHashKey('c7'))
                while not HasModelLoaded(GetHashKey('c7')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('c7'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            elseif spawn == 27 then
                RequestModel(GetHashKey('cheetah2'))
                while not HasModelLoaded(GetHashKey('cheetah2')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('cheetah2'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            elseif spawn == 28 then
                RequestModel(GetHashKey('furia'))
                while not HasModelLoaded(GetHashKey('furia')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('furia'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            elseif spawn == 29 then
                RequestModel(GetHashKey('tempesta2'))
                while not HasModelLoaded(GetHashKey('tempesta2')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('tempesta2'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            elseif spawn == 30 then
                RequestModel(GetHashKey('gt63'))
                while not HasModelLoaded(GetHashKey('gt63')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('gt63'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            elseif spawn == 31 then
                RequestModel(GetHashKey('911turbos'))
                while not HasModelLoaded(GetHashKey('911turbos')) do
                Citizen.Wait(0)
                end
                SetNewWaypoint(CarLocation.x, CarLocation.y)
                local spawncar = AddBlipForCoord(CarLocation.x, CarLocation.y, CarLocation.z)
                    SetBlipScale(spawncar, 1.3)
                    SetBlipSprite(spawncar,  274)
                    SetBlipColour(spawncar,  2)
                    SetBlipAlpha(spawncar, alpha)
                    SetBlipAsShortRange(spawncar, true)
                    BeginTextCommandSetBlipName("STRING")           
                    AddTextComponentString('spawncar')             
                    EndTextCommandSetBlipName(spawncar)
                    SetBlipAsShortRange(spawncar,  1)
                ClearAreaOfVehicles(CarLocation.x, CarLocation.y, CarLocation.z, 15.0, false, false, false, false, false) 			
                SpawnVehicle = CreateVehicle(GetHashKey('911turbos'), CarLocation.x, CarLocation.y, CarLocation.z, 52.0, true, true)   
                SetVehicleNumberPlateText(SpawnVehicle, plate)
                exports['LegacyFuel']:SetFuel(SpawnVehicle, 100.0)
            end
        QBCore.Functions.Notify("Localização recebida", "success")
    end)
end
-----------------------------------
-- fazer a repetição pra policia --
-----------------------------------
function greencar()
    Citizen.CreateThread(function()
        ShouldCallPolice = true
        while ShouldCallPolice do
            TriggerEvent('robberycar:server:callCops')
            Citizen.Wait(30000)
        end
    end)

    Citizen.CreateThread(function()
        Citizen.Wait(300000)
        ShouldCallPolice = false
        entregagreen()
    end)
end

function redcar()
    Citizen.CreateThread(function()
        ShouldCallPolice = true
        while ShouldCallPolice do
            TriggerEvent('robberycar:server:callCops')
            Citizen.Wait(30000)
        end
    end)

    Citizen.CreateThread(function()
        Citizen.Wait(600000)
        ShouldCallPolice = false
        entregared()
    end)
end

function yellowcar()
    Citizen.CreateThread(function()
        ShouldCallPolice = true
        while ShouldCallPolice do
            TriggerEvent('robberycar:server:callCops')
            Citizen.Wait(30000)
        end
    end)
    Citizen.CreateThread(function()
        Citizen.Wait(900000)
        ShouldCallPolice = false
        entregayellow()
    end)    
end
-----------------------------------
-------- Entrega dos carros -------
-----------------------------------

function entregagreen()
    Citizen.CreateThread(function()
        local entregCoord = math.random(1,6)
        if entregCoord == 1 then
            cardeli = entrega1
        elseif entregCoord == 2 then
            cardeli = entrega2
        elseif entregCoord == 3 then
            cardeli = entrega3
        elseif entregCoord == 4 then
            cardeli = entrega3
        elseif entregCoord == 5 then
            cardeli = entrega2
        elseif entregCoord == 6 then
            cardeli = entrega1
        end
        SetNewWaypoint(cardeli.x, cardeli.y)
        local alpha = 250
        local entrega = AddBlipForCoord(cardeli.x, cardeli.y, cardeli.z)
        SetBlipScale(entrega, 1.3)
        SetBlipSprite(entrega,  274)
        SetBlipColour(entrega,  2)
        SetBlipAlpha(entrega, alpha)
        SetBlipAsShortRange(entrega, true)
        BeginTextCommandSetBlipName("STRING")           
        AddTextComponentString('entrega')             
        EndTextCommandSetBlipName(entrega)
        SetBlipAsShortRange(entrega,  1)
        print("passou aqui")
        Citizen.CreateThread(function()
            print("aqui ta")
            Wait(1000)
            while true do
                local ped = GetPlayerPed(-1)
                local pos = GetEntityCoords(ped)
                local inRange = false
                local SellDistance = GetDistanceBetweenCoords(pos, cardeli.x, cardeli.y, cardeli.z, true)
                if SellDistance < 20 then
                    if IsPedInAnyVehicle(ped) and string.find(GetVehicleNumberPlateText(GetVehiclePedIsIn(ped)), plate) ~= nil then
                        DrawMarker(2, cardeli.x, cardeli.y, cardeli.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.3, 1.3, 1.2, 255, 55, 155, 255, 0, 0, 0, 1, 0, 0, 0)
                        inRange = true
                        if SellDistance < 1 then
                            if not SellStarted then
                                QBCore.Functions.ShowFloatingHelpNotification("[~g~E~w~] Entregar Veículo",vector3(cardeli.x, cardeli.y, cardeli.z))
                                if IsControlJustPressed(0, Keys["E"]) then
                                    TriggerServerEvent("qb-car:paid:green")
                                    inRange = false
                                    QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(ped))
                                    RemoveBlip(entrega)
                                end
                            end
                        end
                    end
                end        
                Citizen.Wait(3)
            end
        end)
    end)
end

function entregared()
    Citizen.CreateThread(function()
        local entregCoord = math.random(1,6)
        if entregCoord == 1 then
            cardeli = entrega1
        elseif entregCoord == 2 then
            cardeli = entrega2
        elseif entregCoord == 3 then
            cardeli = entrega3
        elseif entregCoord == 4 then
            cardeli = entrega3
        elseif entregCoord == 5 then
            cardeli = entrega2
        elseif entregCoord == 6 then
            cardeli = entrega1
        end
        SetNewWaypoint(cardeli.x, cardeli.y)
        local alpha = 250
        local entrega = AddBlipForCoord(cardeli.x, cardeli.y, cardeli.z)
        SetBlipScale(entrega, 1.3)
        SetBlipSprite(entrega,  274)
        SetBlipColour(entrega,  2)
        SetBlipAlpha(entrega, alpha)
        SetBlipAsShortRange(entrega, true)
        BeginTextCommandSetBlipName("STRING")           
        AddTextComponentString('entrega')             
        EndTextCommandSetBlipName(entrega)
        SetBlipAsShortRange(entrega,  1)
        print("passou aqui")
        Citizen.CreateThread(function()
            print("aqui ta")
            Wait(1000)
            while true do
                local ped = GetPlayerPed(-1)
                local pos = GetEntityCoords(ped)
                local inRange = false
                local SellDistance = GetDistanceBetweenCoords(pos, cardeli.x, cardeli.y, cardeli.z, true)
                if SellDistance < 20 then
                    if IsPedInAnyVehicle(ped) and string.find(GetVehicleNumberPlateText(GetVehiclePedIsIn(ped)), plate) ~= nil then
                        DrawMarker(2, cardeli.x, cardeli.y, cardeli.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.3, 1.3, 1.2, 255, 55, 155, 255, 0, 0, 0, 1, 0, 0, 0)
                        inRange = true
                        if SellDistance < 1 then
                            if not SellStarted then
                                QBCore.Functions.ShowFloatingHelpNotification("[~g~E~w~] Entregar Veículo",vector3(cardeli.x, cardeli.y, cardeli.z))
                                if IsControlJustPressed(0, Keys["E"]) then
                                    TriggerServerEvent("qb-car:paid:red")
                                    inRange = false
                                    QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(ped))
                                    RemoveBlip(entrega)
                                end
                            end
                        end
                    end
                end        
                Citizen.Wait(3)
            end
        end)
    end)
end

function entregayellow()
    Citizen.CreateThread(function()
        local entregCoord = math.random(1,6)
        if entregCoord == 1 then
            cardeli = entrega1
        elseif entregCoord == 2 then
            cardeli = entrega2
        elseif entregCoord == 3 then
            cardeli = entrega3
        elseif entregCoord == 4 then
            cardeli = entrega3
        elseif entregCoord == 5 then
            cardeli = entrega2
        elseif entregCoord == 6 then
            cardeli = entrega1
        end
        SetNewWaypoint(cardeli.x, cardeli.y)
        local alpha = 250
        local entrega = AddBlipForCoord(cardeli.x, cardeli.y, cardeli.z)
        SetBlipScale(entrega, 1.3)
        SetBlipSprite(entrega,  274)
        SetBlipColour(entrega,  2)
        SetBlipAlpha(entrega, alpha)
        SetBlipAsShortRange(entrega, true)
        BeginTextCommandSetBlipName("STRING")           
        AddTextComponentString('entrega')             
        EndTextCommandSetBlipName(entrega)
        SetBlipAsShortRange(entrega,  1)
        Citizen.CreateThread(function()
            Wait(1000)
            while true do
                local ped = GetPlayerPed(-1)
                local pos = GetEntityCoords(ped)
                local inRange = false
                local SellDistance = GetDistanceBetweenCoords(pos, cardeli.x, cardeli.y, cardeli.z, true)
        
                if SellDistance < 20 then
                    if IsPedInAnyVehicle(ped) and string.find(GetVehicleNumberPlateText(GetVehiclePedIsIn(ped)), plate) ~= nil then
                        DrawMarker(2, cardeli.x, cardeli.y, cardeli.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.3, 1.3, 1.2, 255, 55, 155, 255, 0, 0, 0, 1, 0, 0, 0)
                        inRange = true
                        if SellDistance < 1 then
                            if not SellStarted then
                                QBCore.Functions.ShowFloatingHelpNotification("[~g~E~w~] Entregar Veículo",vector3(cardeli.x, cardeli.y, cardeli.z))
                                if IsControlJustPressed(0, Keys["E"]) then
                                    QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(ped))
                                    TriggerServerEvent("qb-car:paid:yellow")
                                    inRange = false
                                    RemoveBlip(entrega)
                                end
                            end
                        end
                    end
                end        
                Citizen.Wait(3)
            end
        end)
    end)
end