local db = require 'server.modules.db'
local utils = require 'server.modules.utils'
local framework = require 'server.modules.framework'
local conf = require 'config'

local skills = {}
local skillsCache = {}

local function _warn(functionName, message)
    local resource = GetInvokingResource()
    warn(('[%s] %s: %s'):format(resource, functionName, message))
end

---@param source number
local function isValidSource(source)
    if not DoesPlayerExist(tostring(source)) then
        _warn("isValidSource", ('Invalid source: %s'):format(tostring(source)))
        return false
    end
    return true
end

---@param skillName string
local function isValidSkillName(skillName)
    if type(skillName) ~= "string" or conf.Skills[skillName] == nil then
        _warn("isValidSkillName", ('Invalid skill name: %s'):format(tostring(skillName)))
        return false
    end
    return true
end

---@param skillName string
local function isValidGangSkillName(skillName)
    if type(skillName) ~= "string" or conf.gangSkills[skillName] == nil then
        _warn("isValidGangSkillName", ('Invalid skill name: %s'):format(tostring(skillName)))
        return false
    end
    return true
end

---@param xpAmount number
local function isValidXpAmount(xpAmount)
    if type(xpAmount) ~= "number" or xpAmount < 0 then
        _warn("isValidXpAmount", ('Invalid XP amount: %s'):format(tostring(xpAmount)))
        return false
    end
    return true
end

---@param level number
local function isValidLevel(level)
    if type(level) ~= "number" or level <= 0 then
        _warn("isValidLevel", ('Invalid level: %s'):format(tostring(level)))
        return false
    end
    return true
end

---@param skillName string
---@param level number
local function isLevelInRange(skillName, level)
    local xpTable = utils.xpTables[skillName]
    if level > #xpTable then
        _warn('isLevelInRange', ('Level %d is out of range for skill %s'):format(level, skillName))
        return false
    end
    return true
end

---@param source number|string
---@param skillName string
---@param xpAmount number
local function updateSkillCache(source, skillName, xpAmount)
    skillsCache[source][skillName].xp = skillsCache[source][skillName].xp + xpAmount
    skillsCache[source][skillName].level = utils.calculateLevel(skillsCache[source][skillName].xp, skillName)
end

---@param gangName string
---@param skillName string
---@param xpAmount number
function skills.addGangXp(gangName, skillName, xpAmount)
    if not isValidGangSkillName(skillName) then return end
    if not isValidXpAmount(xpAmount) then return end
    if conf.ignoredGangs[gangName:lower()] then return end

    db.addXp(gangName, skillName, xpAmount)
    updateSkillCache(gangName, skillName, xpAmount)
end

---@param source number
---@param skillName string
---@param xpAmount number
function skills.addPlayerXp(source, skillName, xpAmount)
    if not isValidSource(source) then return end
    if not isValidSkillName(skillName) then return end
    if not isValidXpAmount(xpAmount) then return end

    local charId = framework.getCharacterIdentifier(source)
    if not charId then return end
    db.addXp(charId, skillName, xpAmount)
    updateSkillCache(source, skillName, xpAmount)
end

---@param target number|string
---@param skillName string
---@param xpAmount number
---@param targetType string
function skills.addXp(target, skillName, xpAmount, targetType)
    targetType = targetType or 'player'
    if targetType == 'player' then
        local src = tonumber(target) or 0
        skills.addPlayerXp(src, skillName, xpAmount)
    elseif targetType == 'gang' then
        skills.addGangXp(tostring(target), skillName, xpAmount)
    end
end

exports('addXp', skills.addXp)

---@param gangName string
---@param skillName string
---@param xpAmount number
function skills.removeGangXp(gangName, skillName, xpAmount)
    if not isValidGangSkillName(skillName) then return end
    if not isValidXpAmount(xpAmount) then return end
    if conf.ignoredGangs[gangName:lower()] then return end

    local currentXp = skillsCache[gangName][skillName].xp
    local newXpAmount = math.max(0, currentXp - xpAmount)
    local xpRemoved = currentXp - newXpAmount

    db.removeXp(gangName, skillName, xpRemoved)
    updateSkillCache(gangName, skillName, -xpRemoved)
end


---@param source number
---@param skillName string
---@param xpAmount number
function skills.removePlayerXp(source, skillName, xpAmount)
    if not isValidSource(source) then return end
    if not isValidSkillName(skillName) then return end
    if not isValidXpAmount(xpAmount) then return end

    local charId = framework.getCharacterIdentifier(source)
    if not charId then return end

    local currentXp = skillsCache[source][skillName].xp
    local newXpAmount = math.max(0, currentXp - xpAmount)
    local xpRemoved = currentXp - newXpAmount

    db.removeXp(charId, skillName, xpRemoved)
    updateSkillCache(source, skillName, -xpRemoved)
end

---@param target number|string
---@param skillName string
---@param xpAmount number
---@param targetType string
function skills.removeXp(target, skillName, xpAmount, targetType)
    targetType = targetType or 'player'
    if targetType == 'player' then
        local src = tonumber(target) or 0
        skills.removePlayerXp(src, skillName, xpAmount)
    elseif targetType == 'gang' then
        skills.removeGangXp(tostring(target), skillName, xpAmount)
    end
end

exports('removeXp', skills.removeXp)

---@param source number|string
---@param skillName string
---@param targetType string
---@return number
function skills.getSkillLevel(source, skillName, targetType)
    targetType = targetType or 'player'
    if targetType == 'player' and
        (not isValidSource(source --[[@as number]]) or not isValidSkillName(skillName))
    then
        return 0
    elseif targetType == 'gang' and
        (not isValidGangSkillName(skillName) or conf.ignoredGangs[source:lower()])
    then
        return 0
    end

    return skillsCache[source] and skillsCache[source][skillName] and skillsCache[source][skillName].level or 0
end

exports('getSkillLevel', skills.getSkillLevel)

---@param source number|string
---@param skillName string
---@param targetType string
---@return number
function skills.getSkillXp(source, skillName, targetType)
    targetType = targetType or 'player'
    if targetType == 'player' and
        (not isValidSource(source --[[@as number]]) or not isValidSkillName(skillName))
    then
        return 0
    elseif targetType == 'gang' and
        (not isValidGangSkillName(skillName) or conf.ignoredGangs[source:lower()])
    then
        return 0
    end

    return skillsCache[source] and skillsCache[source][skillName] and skillsCache[source][skillName].xp or 0
end

exports('getSkillXp', skills.getSkillXp)

-- ---@param source number
-- ---@param skillName string
-- ---@param level number
-- function skills.setSkillLevel(source, skillName, level)
--     if not isValidSource(source) then return end
--     if not isValidSkillName(skillName) then return end
--     if not isValidLevel(level) then return end
--     if not isLevelInRange(skillName, level) then return end

--     local charId = framework.getCharacterIdentifier(source)
--     if not charId then return end
--     local xpTable = utils.xpTables[skillName]

--     local xpAmount = (level > 1) and (xpTable[level - 1]) or 0
--     db.setXp(charId, skillName, xpAmount)
--     skillsCache[source][skillName] = { xp = xpAmount, level = level }
-- end

-- exports('setSkillLevel', skills.setSkillLevel)

-- ---@param source number
-- ---@param skillName string
-- function skills.resetSkill(source, skillName)
--     if not isValidSource(source) then return end
--     if not isValidSkillName(skillName) then return end

--     local charId = framework.getCharacterIdentifier(source)
--     if not charId then return end
--     db.resetSkill(charId, skillName)
--     skillsCache[source][skillName] = { xp = 0, level = 1 }
-- end

-- exports('resetSkill', skills.resetSkill)

---@param source number
---@return table<string, { xp: number, level: number }>
function skills.getAllGangSkills(source)
    if not isValidSource(source) then return {} end
    local gangName = framework.getCharacterGang(source)
    if not gangName then return {} end
    return skillsCache[gangName] or {}
end

exports('getAllGangSkills', skills.getAllGangSkills)

---@param source number
---@return table<string, { xp: number, level: number }>
function skills.getAllSkills(source)
    if not isValidSource(source) then return {} end

    return skillsCache[source] or {}
end

exports('getAllSkills', skills.getAllSkills)

---@param source number
---@param skillName string
function skills.hasSkill(source, skillName)
    if not isValidSource(source) then return end
    if not isValidSkillName(skillName) then return end

    return skillsCache[source] and skillsCache[source][skillName] ~= nil
end

exports('hasSkill', skills.hasSkill)

---@param source number
function skills.playerLoaded(source)
    local charId = framework.getCharacterIdentifier(source)
    if not charId then return end

    if not skillsCache[source] then
        local playerSkills = db.getEntitySkills(charId)
        local playerSkillSet = {}
        for _, pSkillData in ipairs(playerSkills) do
            if conf.Skills[pSkillData.skill_name] then
                playerSkillSet[pSkillData.skill_name] = {
                    xp = pSkillData.xp,
                    level = utils.calculateLevel(pSkillData.xp, pSkillData.skill_name)
                }
            end
        end
        skillsCache[source] = playerSkillSet
    end

    for skillName, _ in pairs(conf.Skills) do
        if not skillsCache[source][skillName] then
            db.insertNewEntitySkill(charId, skillName)
            skillsCache[source][skillName] = { xp = 0, level = 1 }
        end
    end
end

function skills.initGangSkills()
    local gangs = framework.getAllGangs()
    for gangName, _ in pairs(gangs) do
        if not conf.ignoredGangs[gangName:lower()] then
            local gangSkills = db.getEntitySkills(gangName)
            local gangSkillSet = {}
            for _, gSkillData in ipairs(gangSkills) do
                if conf.gangSkills[gSkillData.skill_name] then
                    gangSkillSet[gSkillData.skill_name] = {
                        xp = gSkillData.xp,
                        level = utils.calculateLevel(gSkillData.xp, gSkillData.skill_name)
                    }
                end
            end
            skillsCache[gangName] = gangSkillSet
        end
    end

    for skillName, _ in pairs(conf.gangSkills) do
        for gangName, _ in pairs(gangs) do
            if not conf.ignoredGangs[gangName:lower()] and not skillsCache[gangName][skillName] then
                db.insertNewEntitySkill(gangName, skillName)
                skillsCache[gangName][skillName] = { xp = 0, level = 1 }
            end
        end
    end
end

return skills
