local skills = require 'server.modules.skills'
local utils = require 'server.modules.utils'
local conf = require 'config'
local db = require 'server.modules.db'

local function initializeFramework()
    local validFrameworks = { qb = true, qbx = true, esx = true }
    local framework = string.lower(conf.Framework)
    if not validFrameworks[framework] then
        error(('Framework \'%s\' is not supported.'):format(framework))
    end
    return (framework == 'qb' or framework == 'qbx') and 'QBCore:Server:OnPlayerLoaded' or 'esx:playerLoaded'
end

local onLoadedEvent = initializeFramework()

local function getPlayerSkills(source)
    local skillsData = {}
    local skillsCache = skills.getAllSkills(source)
    for skillName, skillInfo in pairs(skillsCache) do
        local skillConfig = conf.Skills[skillName]
        if skillConfig then
            local minXp, maxXp = utils.getXpRangeForLevel(skillInfo.level, skillName, skillConfig)
            skillsData[#skillsData + 1] = {
                label = skillConfig.label,
                description = skillConfig.description,
                level = skillInfo.level,
                xp = skillInfo.xp,
                levelData = { minXp = minXp, maxXp = math.ceil(maxXp) },
                icon = skillConfig.icon,
                color = skillConfig.color
            }
        end
    end
    return skillsData
end

local function getGangSkills(source)
    local gangSkills = skills.getAllGangSkills(source)
    local skillsData = {}
    for skillName, skillInfo in pairs(gangSkills) do
        local skillConfig = conf.gangSkills[skillName]
        if skillConfig then
            local minXp, maxXp = utils.getXpRangeForLevel(skillInfo.level, skillName, skillConfig)
            skillsData[#skillsData + 1] = {
                label = skillConfig.label,
                description = skillConfig.description,
                level = skillInfo.level,
                xp = skillInfo.xp,
                levelData = { minXp = minXp, maxXp = math.ceil(maxXp) },
                icon = skillConfig.icon,
                color = skillConfig.color
            }
        end
    end
    return skillsData
end

local function getGangSkillLevel(source, skillName)
    local gangSkills = skills.getAllGangSkills(source)
    local skillInfo = gangSkills[skillName]
    if not skillInfo then return end

    return skillInfo.level
end

local function getGangSkillXp(source, skillName)
    local gangSkills = skills.getAllGangSkills(source)
    local skillInfo = gangSkills[skillName]
    if not skillInfo then return end

    return skillInfo.xp
end

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end

    db.ensureSkillsTable()

    skills.initGangSkills()

    local activePlayers = GetPlayers()
    for i = 1, #activePlayers do
        ---@diagnostic disable-next-line
        skills.playerLoaded(tonumber(activePlayers[i]))
    end
end)

RegisterNetEvent(onLoadedEvent, function()
    ---@diagnostic disable-next-line
    skills.playerLoaded(source)
end)

lib.callback.register('ss_skills:server:getSkills', getPlayerSkills)
lib.callback.register('ss_skills:server:getSkillLevel', skills.getSkillLevel)
lib.callback.register('ss_skills:server:getSkillXp', skills.getSkillXp)

lib.callback.register('ss_skills:server:getGangSkills', getGangSkills)
lib.callback.register('ss_skills:server:getGangSkillLevel', getGangSkillLevel)
lib.callback.register('ss_skills:server:getGangSkillXp', getGangSkillXp)
