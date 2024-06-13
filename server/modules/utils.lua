local conf = require 'config'

local utils = {}

---@param skillConfig table
local function precomputeXpRequirements(skillConfig)
    local xpTable = {}
    local currentMaxXp = skillConfig.baseXp
    xpTable[1] = currentMaxXp

    for level = 2, skillConfig.maxLevel do
        currentMaxXp = math.ceil(currentMaxXp * skillConfig.nextLevelMultiplier)
        xpTable[level] = currentMaxXp
    end

    return xpTable
end

utils.xpTables = {}
for skillName, skillConfig in pairs(conf.Skills) do
    utils.xpTables[skillName] = precomputeXpRequirements(skillConfig)
end
for skillName, skillConfig in pairs(conf.gangSkills) do
    utils.xpTables[skillName] = precomputeXpRequirements(skillConfig)
end

---@param xpAmount number
---@param skillName string
function utils.calculateLevel(xpAmount, skillName)
    local xpTable = utils.xpTables[skillName]
    local level = 1
    while level < #xpTable and xpAmount >= xpTable[level] do
        level = level + 1
    end
    return level
end

function utils.getXpRangeForLevel(level, skillName, skillConfig)
    local xpTable = utils.xpTables[skillName]
    if not xpTable then
        error(('Skill \'%s\' is not configured!'):format(skillName), 1)
    end

    local minXp = (level > 1) and xpTable[level - 1] or 0
    local maxXp
    if level < #xpTable then
        maxXp = xpTable[level]
    else
        maxXp = math.ceil(xpTable[level] * skillConfig.nextLevelMultiplier)
    end

    return minXp, maxXp
end

---@param source number
---@param skill string
---@param target number
---@param value number
---@param isLevel boolean
function utils.validateSkillCommand(source, skill, target, value, isLevel, targetType)
    targetType = targetType or 'player'
    local skillConfig = targetType == 'gang' and conf.gangSkills[skill] or conf.Skills[skill]
    if not skillConfig then
        lib.notify(source, {
            title = 'Skills',
            description = ('Skill %s does not exist'):format(skill),
            type = 'error'
        })
        return false
    end

    if targetType == 'player' and not DoesPlayerExist(tostring(target)) then
        lib.notify(source, {
            title = 'Skills',
            description = ('Player with the ID of %s does not exist'):format(tostring(target)),
            type = 'error'
        })
        return false
    end

    if isLevel then
        if type(value) ~= 'number' or value <= 0 or value > skillConfig.maxLevel then
            lib.notify(source, {
                title = 'Skills',
                description = ('Level must be a number between 1 and %d'):format(skillConfig.maxLevel),
                type = 'error'
            })
            return false
        end
    else
        if type(value) ~= 'number' or value <= 0 then
            lib.notify(source, {
                title = 'Skills',
                description = 'Amount of XP must be a positive number',
                type = 'error'
            })
            return false
        end
    end

    return true
end

return utils
