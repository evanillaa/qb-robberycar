QBCore = nil

cooldown = {}

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-----------------------------------
----------- Inicio do roubo -------
-----------------------------------
RegisterServerEvent("xp-car:sv:pendrive")
AddEventHandler("xp-car:sv:pendrive", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local pendrive_green = Player.Functions.GetItemByName("pendrive_green")
    local pendrive = QBCore.Shared.Items["pendrive_green"]
    local pendrive_red = Player.Functions.GetItemByName("pendrive_red")
    local pendrive = QBCore.Shared.Items["pendrive_red"]
    local pendrive_yellow = Player.Functions.GetItemByName("pendrive_yellow")
    local pendrive = QBCore.Shared.Items["pendrive_yellow"]
   
    if pendrive_green ~= nil and pendrive_green.amount >= 1 then
        if cooldown[Player.PlayerData.citizenid] == nil then
            Citizen.CreateThread(function()
                Player.Functions.RemoveItem('pendrive_green', 1)
                TriggerClientEvent('inventory:client:ItemBox', src, pendrive, "remove")
                TriggerClientEvent("xp-car:cl:progressbar", src)
                Citizen.Wait(10000)

                TriggerClientEvent("xp-car:cl:green", src)
            end)
        else
            TriggerClientEvent('QBCore:Notify', src, 'Aguarde antes de tentar hackear o indiano!', 'inform')
        end
    elseif pendrive_red ~= nil and pendrive_red.amount >= 1 then
        if cooldown[Player.PlayerData.citizenid] == nil then
            Citizen.CreateThread(function()
                Player.Functions.RemoveItem('pendrive_red', 1)
                TriggerClientEvent('inventory:client:ItemBox', src, pendrive, "remove")
                TriggerClientEvent("xp-car:cl:progressbar", src)
                Citizen.Wait(10000)

                TriggerClientEvent("xp-car:cl:red", src)
            end)
        else
            TriggerClientEvent('QBCore:Notify', src, 'Aguarde antes de tentar hackear o indiano!', 'inform')
        end
    elseif pendrive_yellow ~= nil and pendrive_yellow.amount >= 1 then
        if cooldown[Player.PlayerData.citizenid] == nil then
            Citizen.CreateThread(function()
                Player.Functions.RemoveItem('pendrive_yellow', 1)
                TriggerClientEvent('inventory:client:ItemBox', src, pendrive, "remove")
                TriggerClientEvent("xp-car:cl:progressbar", src)
                Citizen.Wait(10000)

                TriggerClientEvent("xp-car:cl:yellow", src)
            end)
        else
            TriggerClientEvent('QBCore:Notify', src, 'Aguarde antes de tentar hackear o indiano!', 'inform')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'ERROR 404', 'error')
    end
end)
-----------------------------------
--------- cria itens usaveis ------
-----------------------------------
QBCore.Functions.CreateUseableItem("chave_green", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local chave_green = Player.Functions.GetItemByName("chave_green")
    local pendrive = QBCore.Shared.Items["chave_green"]

    Player.Functions.RemoveItem('chave_green', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, pendrive, "remove")
    TriggerClientEvent("xp-car:chave:green", src)
end)

QBCore.Functions.CreateUseableItem("chave_red", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local chave_red = Player.Functions.GetItemByName("chave_red")
    local pendrive = QBCore.Shared.Items["chave_red"]

    Player.Functions.RemoveItem('chave_red', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, pendrive, "remove")
    TriggerClientEvent("xp-car:chave:red", src)
end)

QBCore.Functions.CreateUseableItem("chave_yellow", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local chave_yellow = Player.Functions.GetItemByName("chave_yellow")
    local pendrive = QBCore.Shared.Items["chave_yellow"]

    TriggerClientEvent("xp-car:chave:yellow", src)
    Player.Functions.RemoveItem('chave_yellow', 1)
    TriggerwClientEvent('inventory:client:ItemBox', src, pendrive, "remove")
   
end)
-----------------------------------
---- Evento para entregar chave ---
-----------------------------------
RegisterServerEvent("xp-car:additem:green")
AddEventHandler("xp-car:additem:green", function()
    local Player = QBCore.Functions.GetPlayer(source)
    local chave_green = QBCore.Shared.Items["chave_green"]
    Player.Functions.AddItem('chave_green', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, chave_green, "add")
end)

RegisterServerEvent("xp-car:additem:red")
AddEventHandler("xp-car:additem:red", function()
    local Player = QBCore.Functions.GetPlayer(source)
    local chave_red = QBCore.Shared.Items["chave_red"]
    Player.Functions.AddItem('chave_red', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, chave_red, "add")
end)

RegisterServerEvent("xp-car:additem:yellow")
AddEventHandler("xp-car:additem:yellow", function()
    local Player = QBCore.Functions.GetPlayer(source)
    local chave_yellow = QBCore.Shared.Items["chave_yellow"]
    Player.Functions.AddItem('chave_yellow', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, chave_yellow, "add")
end)
-----------------------------------
---- Evento para pagar o player ---
-----------------------------------
RegisterServerEvent("xp-car:paid:green")
AddEventHandler("xp-car:paid:green", function()
    local Player = QBCore.Functions.GetPlayer(source)
    local bills = QBCore.Shared.Items["bills"]
    Player.Functions.AddItem('bills', math.random(2000,4000))
    TriggerClientEvent('inventory:client:ItemBox', source, bills, "add")
end)

RegisterServerEvent("xp-car:paid:red")
AddEventHandler("xp-car:paid:red", function()
    local Player = QBCore.Functions.GetPlayer(source)
    local bills = QBCore.Shared.Items["bills"]
    Player.Functions.AddItem('bills', math.random(4000,6000))
    TriggerClientEvent('inventory:client:ItemBox', source, bills, "add")
end)

RegisterServerEvent("xp-car:paid:yellow")
AddEventHandler("xp-car:paid:yellow", function()
    local Player = QBCore.Functions.GetPlayer(source)
    local bills = QBCore.Shared.Items["bills"]
    Player.Functions.AddItem('bills', math.random(6000,10000))
    TriggerClientEvent('inventory:client:ItemBox', source, bills, "add")
end)