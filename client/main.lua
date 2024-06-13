-- Player skills

---@param skillName string
local function getSkillLevel(skillName)
    return lib.callback.await('ss_skills:server:getSkillLevel', false, skillName)
end

exports('getSkillLevel', getSkillLevel)

---@param skillName string
local function getSkillXp(skillName)
    return lib.callback.await('ss_skills:server:getSkillXp', false, skillName)
end

exports('getSkillXp', getSkillXp)

local function getSkills()
    return lib.callback.await('ss_skills:server:getSkills', false)
end

exports('getSkills', getSkills)

-- Gang skills

local function getGangSkillLevel(skillName)
    return lib.callback.await('ss_skills:server:getGangSkillLevel', false, skillName)
end

exports('getGangSkillLevel', getGangSkillLevel)

local function getGangSkillXp(skillName)
    return lib.callback.await('ss_skills:server:getGangSkillXp', false, skillName)
end

exports('getGangSkillXp', getGangSkillXp)

local function getGangSkills()
    return lib.callback.await('ss_skills:server:getGangSkills', false)
end

exports('getGangSkills', getGangSkills)
