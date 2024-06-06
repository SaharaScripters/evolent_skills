---@class Skill
---@field label string
---@field baseXp number
---@field nextLevelMultiplier number
---@field maxLevel number
---@field icon string
---@field color string

return {
    ---@type 'qb'|'qbx'|'esx'
    Framework = 'qb',

    ---@type string
    UIHotkey = 'J',

    --- @type table<string, Skill>
    Skills = {
        driving = {
            label = 'Driving',
            baseXp = 120,
            nextLevelMultiplier = 1.4,
            maxLevel = 100,
            icon = 'fas fa-car',
            color = '#AFC1FF'
        },
        piloting = {
            label = 'Piloting',
            baseXp = 200,
            nextLevelMultiplier = 1.7,
            maxLevel = 120,
            icon = 'fas fa-helicopter',
            color = '#4B0082'
        },
        sailing = {
            label = 'Sailing',
            baseXp = 180,
            nextLevelMultiplier = 1.6,
            maxLevel = 100,
            icon = 'fas fa-ship',
            color = '#00008B'
        },
        mining = {
            label = 'Mining',
            baseXp = 100,
            nextLevelMultiplier = 1.6,
            maxLevel = 100,
            icon = 'fas fa-hard-hat',
            color = '#D2B48C'
        },
        farming = {
            label = 'Farming',
            baseXp = 80,
            nextLevelMultiplier = 1.5,
            maxLevel = 100,
            icon = 'fas fa-wheat-awn',
            color = '#A0D468'
        },
        fishing = {
            label = 'Fishing',
            baseXp = 90,
            nextLevelMultiplier = 1.4,
            maxLevel = 100,
            icon = 'fas fa-fish',
            color = '#81C7D4'
        },
        cooking = {
            label = 'Cooking',
            baseXp = 120,
            nextLevelMultiplier = 1.3,
            maxLevel = 100,
            icon = 'fas fa-utensils',
            color = '#FF9F40'
        },
        crafting = {
            label = 'Crafting',
            baseXp = 150,
            nextLevelMultiplier = 1.5,
            maxLevel = 100,
            icon = 'fas fa-hammer',
            color = '#D2691E'
        },
        streetArt = {
            label = 'Street Art',
            baseXp = 60,
            nextLevelMultiplier = 1.4,
            maxLevel = 50,
            icon = 'fas fa-spray-can',
            color = '#FF7F50'
        },
        hacking = {
            label = 'Hacking',
            baseXp = 250,
            nextLevelMultiplier = 1.8,
            maxLevel = 150,
            icon = 'fas fa-code',
            color = '#32CD32'
        },
        cornerselling = {
            label = 'Corner Selling',
            baseXp = 30,
            nextLevelMultiplier = 1.8,
            maxLevel = 100,
            icon = 'fas fa-pills',
            color = '#7aff81'
        },
        shooting = {
            label = 'Shooting',
            baseXp = 120,
            nextLevelMultiplier = 1.5,
            maxLevel = 150,
            icon = 'fas fa-gun',
            color = '#ff5959'
        },
    }
}
