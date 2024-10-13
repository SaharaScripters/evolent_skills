---@class Skill
---@field label string
---@field description string
---@field baseXp number
---@field nextLevelMultiplier number
---@field maxLevel number
---@field icon string
---@field color string

return {
    ---@type 'qb'|'qbx'|'esx'
    Framework = 'qbx',

    ---@type string
    --UIHotkey = 'J',

    --- @type table<string, Skill>
    Skills = {
        driving = {
            label = 'Driving',
            description = 'Do you have a driver\'s license?',
            baseXp = 120,
            nextLevelMultiplier = 1.4,
            maxLevel = 100,
            icon = 'fas fa-car',
            color = '#AFC1FF'
        },
        piloting = {
            label = 'Piloting',
            description = 'Have you ever flown a plane?',
            baseXp = 200,
            nextLevelMultiplier = 1.7,
            maxLevel = 120,
            icon = 'fas fa-helicopter',
            color = '#4B0082'
        },
        sailing = {
            label = 'Sailing',
            description = 'How many times have you been on a boat?',
            baseXp = 180,
            nextLevelMultiplier = 1.6,
            maxLevel = 100,
            icon = 'fas fa-ship',
            color = '#00008B'
        },
        mining = {
            label = 'Mining',
            description = 'Do you like to dig?',
            baseXp = 100,
            nextLevelMultiplier = 1.6,
            maxLevel = 100,
            icon = 'fas fa-hard-hat',
            color = '#D2B48C'
        },
        farming = {
            label = 'Farming',
            description = 'If you plant a seed today, you will reap tomorrow.',
            baseXp = 80,
            nextLevelMultiplier = 1.5,
            maxLevel = 100,
            icon = 'fas fa-wheat-awn',
            color = '#A0D468'
        },
        fishing = {
            label = 'Fishing',
            description = 'Show me how you fish, and I will tell you who you are.',
            baseXp = 90,
            nextLevelMultiplier = 1.4,
            maxLevel = 100,
            icon = 'fas fa-fish',
            color = '#81C7D4'
        },
        cooking = {
            label = 'Cooking',
            description = 'Cooking is an art, and art is patience.',
            baseXp = 120,
            nextLevelMultiplier = 1.3,
            maxLevel = 100,
            icon = 'fas fa-utensils',
            color = '#FF9F40'
        },
        crafting = {
            label = 'Crafting',
            description = 'Many gadgets, many crafts.',
            baseXp = 150,
            nextLevelMultiplier = 1.5,
            maxLevel = 100,
            icon = 'fas fa-hammer',
            color = '#D2691E'
        },
        streetArt = {
            label = 'Street Art',
            description = 'Art is not a crime.',
            baseXp = 60,
            nextLevelMultiplier = 1.4,
            maxLevel = 50,
            icon = 'fas fa-spray-can',
            color = '#FF7F50'
        },
        lockpicking = {
            label = 'Lockpicking',
            description = 'The key to success is to start the engine.',
            baseXp = 100,
            nextLevelMultiplier = 2.0,
            maxLevel = 200,
            icon = 'fas fa-key',
            color = '#FFD700'
        },
        hacking = {
            label = 'Hacking',
            description = 'Never underestimate the power of a computer.',
            baseXp = 250,
            nextLevelMultiplier = 1.8,
            maxLevel = 150,
            icon = 'fas fa-code',
            color = '#32CD32'
        },
        cornerselling = {
            label = 'Corner Selling',
            description = 'Always be ready to sell.',
            baseXp = 30,
            nextLevelMultiplier = 1.8,
            maxLevel = 100,
            icon = 'fas fa-pills',
            color = '#7aff81'
        },
        shooting = {
            label = 'Shooting',
            description = 'Aim for the head.',
            baseXp = 120,
            nextLevelMultiplier = 1.5,
            maxLevel = 150,
            icon = 'fas fa-gun',
            color = '#ff5959'
        },
        pickpocket = {
            label = 'Pick pocket',
            description = 'Can you steal a candy bar?',
            baseXp = 100,
            nextLevelMultiplier = 1.5,
            maxLevel = 100,
            icon = 'fas fa-hand-holding-dollar',
            color = '#e6e6e6',
        },
        kidnapping = {
            label = 'Kidnapping',
            description = 'Who do you want to kidnap?',
            baseXp = 100,
            nextLevelMultiplier = 1.5,
            maxLevel = 100,
            icon = 'fas fa-user-slash',
            color = '#ff7f50',
        },
        houserobbery = {
            label = 'House Robbery',
            description = 'Do you know how to rob a house?',
            baseXp = 100,
            nextLevelMultiplier = 1.5,
            maxLevel = 100,
            icon = 'fas fa-home',
            color = '#ff7f50',
        },
    },
    ignoredGangs = {
        ['none'] = true,
    },
    gangSkills = {
        territory_control = {
            label = 'Territory Control',
            description = 'Can you control the territory?',
            baseXp = 100,
            nextLevelMultiplier = 1.5,
            maxLevel = 100,
            icon = 'fas fa-map-marked-alt',
            color = '#af7cff'
        },
        drugtrafficking = {
            label = 'Drug Trafficking',
            description = 'Do you know how to sell drugs?',
            baseXp = 100,
            nextLevelMultiplier = 1.5,
            maxLevel = 100,
            icon = 'fas fa-pills',
            color = '#ff7f50',
        },
        brutality = {
            label = 'Brutality',
            description = 'Show no mercy!',
            baseXp = 100,
            nextLevelMultiplier = 1.5,
            maxLevel = 100,
            icon = 'fas fa-fist-raised',
            color = '#ff8888',
        },
    }
}
