local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('neko_dumpster:server:giverandomreward')
AddEventHandler('neko_dumpster:server:giverandomreward', function()
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local randomItem = Config.Items[math.random(1, #Config.Items)]
    local totalGive = math.random(Config.RewardMin, Config.RewardMax)
    if xPlayer.Functions.AddItem(randomItem, totalGive) then
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[randomItem], "add")
    else
        TriggerClientEvent("QBCore:Notify", source, "No tienes suficiente espacio", "error")
    end
end)