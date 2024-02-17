local QBCore = exports['qb-core']:GetCoreObject()
local lootedDumpsters = {}

exports['qb-target']:AddTargetModel(Config.DumpstersProps, {
    options = {
        {
            type = 'client',
            event = 'neko_dumpster:client:searchdumpster',
            icon = 'fas fa-search',
            label = 'Revisar basurero',
            action = function(entity)
                if IsEntityLooted(entity) then return false end
                TriggerEvent('neko_dumpster:client:searchdumpster', entity)
            end,
            canInteract = function(entity, distance, data)
                if IsEntityLooted(entity) then return false end
                return true
            end
        }
    },
    distance = 1.5,
})

RegisterNetEvent('neko_dumpster:client:searchdumpster', function(entity)
    QBCore.Functions.Progressbar('dumpsters', 'Revisando el contenedor', 5500, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@prop_human_bum_bin@base',
        anim = 'base',
        flags = 49,
    }, {}, {}, function()
        TriggerServerEvent('neko_dumpster:server:giverandomreward')
        EntityLooted(entity)
    end, function()
        QBCore.Functions.Notify('Has dejado de buscar', 'error')
    end)
end)


function IsEntityLooted(entity)
    local looted = false
    for dumpster, timestamp in pairs(lootedDumpsters) do
        if dumpster == entity then
            local timeDiff = GetGameTimer() - timestamp
            if timeDiff >= ((Config.WaitTime * 60) * 1000) then
                lootedDumpsters[dumpster] = nil
                looted = false
            else
                looted = true
            end
        end
    end
    return looted
end

function EntityLooted(entity)
    if IsEntityLooted(entity) then return end
    lootedDumpsters[entity] = GetGameTimer()
end