local conf = require 'config'

local function createFrameworkAdapter(framework)
    local adapter = {}

    if framework == 'qb' then
        local coreObject = exports['qb-core']:GetCoreObject()
        function adapter.getCharacterIdentifier(source)
            return coreObject.Functions.GetPlayer(source)?.PlayerData?.citizenid
        end
        function adapter.getCharacterGang(source)
            return coreObject.Functions.GetPlayer(source)?.PlayerData?.gang.name
        end
        function adapter.getAllGangs()
            local gangs = {}
            for gangName, gangData in pairs(coreObject.Functions.GetGangs()) do
                gangs[gangName] = gangData.label
            end
            return gangs
        end
    elseif framework == 'qbx' then
        function adapter.getCharacterIdentifier(source)
            return exports.qbx_core:GetPlayer(source)?.PlayerData?.citizenid
        end
        function adapter.getCharacterGang(source)
            return exports.qbx_core:GetPlayer(source)?.PlayerData?.gang.name
        end
        function adapter.getAllGangs()
            local gangs = {}
            for gangName, gangData in pairs(exports.qbx_core:GetGangs()) do
                gangs[gangName] = gangData.label
            end
            return gangs
        end
    elseif framework == 'qbx' then
        function adapter.getCharacterIdentifier(source)
            return exports.qbx_core:GetPlayer(source)?.PlayerData?.citizenid
        end
    elseif framework == 'esx' then
        local coreObject = exports['es_extended']:getSharedObject()
        function adapter.getCharacterIdentifier(source)
            local player = coreObject.GetPlayerFromId(source)
            return player and player.getIdentifier() or nil
        end
        function adapter.getCharacterGang(source)
            local player = coreObject.GetPlayerFromId(source)
            return player and player.getGang() or nil
        end
        function adapter.getAllGangs()
            return {}
        end
    end

    return adapter
end

local fwFunctions = createFrameworkAdapter(conf.Framework)

return fwFunctions
