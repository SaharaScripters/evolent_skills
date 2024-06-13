local MySQL = MySQL
local db = {}

---@param id string
---@return table
function db.getEntitySkills(id)
    return MySQL.query.await('SELECT skill_name, xp FROM ss_skills WHERE id = ?', { id })
end

---@param id string
---@param skillName string
function db.insertNewEntitySkill(id, skillName)
    MySQL.prepare('INSERT INTO ss_skills (id, skill_name) VALUES (?, ?)', { id, skillName })
end

---@param id string
---@param skillName string
---@param xpAmount number
function db.addXp(id, skillName, xpAmount)
    MySQL.prepare('UPDATE ss_skills SET xp = xp + ? WHERE id = ? AND skill_name = ?', { xpAmount, id, skillName })
end

---@param id string
---@param skillName string
---@param xpAmount number
function db.removeXp(id, skillName, xpAmount)
    MySQL.prepare('UPDATE ss_skills SET xp = GREATEST(xp - ?, 0) WHERE id = ? AND skill_name = ?', { xpAmount, id, skillName })
end

---@param id string
---@param skillName string
---@param xpAmount number
function db.setXp(id, skillName, xpAmount)
    MySQL.prepare('UPDATE ss_skills SET xp = ? WHERE id = ? AND skill_name = ?', { xpAmount, id, skillName })
end

---@param id string
---@param skillName string
function db.resetSkill(id, skillName)
    MySQL.prepare('UPDATE ss_skills SET xp = 0 WHERE id = ? AND skill_name = ?', { id, skillName })
end

function db.ensureSkillsTable()
    MySQL.query.await([[
        CREATE TABLE IF NOT EXISTS ss_skills (
            id VARCHAR(255) NOT NULL,
            skill_name VARCHAR(100) NOT NULL,
            xp INT DEFAULT 0,
            PRIMARY KEY (id, skill_name)
        )
    ]])
end

return db
