local skills = require 'server.modules.skills'
local utils = require 'server.modules.utils'

lib.addCommand('addxp', {
    help = 'Add XP to a gang/player\'s skill',
    params = {
        {
            name = 'target',
            help = 'Target player\'s server id or gang name'
        },
        {
            name = 'skill',
            type = 'string',
            help = 'Name of skill'
        },
        {
            name = 'amount',
            type = 'number',
            help = 'Amount of XP to give'
        },
        {
            name = 'targetType',
            type = 'string',
            help = 'Type of target (player or gang)',
            optional = true,
        },
    },
    restricted = 'group.admin'
}, function(source, args)
    local skill = args.skill
    local amount = args.amount
    local target = args.target
    local targetType = args.targetType or 'player'

    if not utils.validateSkillCommand(source, skill, target, amount, false, targetType) then
        return
    end

    skills.addXp(target, skill, amount, targetType)
    local targetName = targetType == 'player' and GetPlayerName(target) or target
    lib.notify(source, {
        title = 'Skills',
        description = ('Added %d XP to %s for %s skill'):format(amount, targetName, skill),
        type = 'success'
    })
end)

lib.addCommand('removexp', {
    help = 'Remove XP from a player\'s skill',
    params = {
        {
            name = 'target',
            help = 'Target player\'s server id'
        },
        {
            name = 'skill',
            type = 'string',
            help = 'Name of skill'
        },
        {
            name = 'amount',
            type = 'number',
            help = 'Amount of XP to remove'
        },
        {
            name = 'targetType',
            type = 'string',
            help = 'Type of target (player or gang)',
            optional = true,
        },
    },
    restricted = 'group.admin'
}, function(source, args)
    local skill = args.skill
    local amount = args.amount
    local target = args.target
    local targetType = args.targetType or 'player'

    if not utils.validateSkillCommand(source, skill, target, amount, false, targetType) then
        return
    end

    skills.removeXp(target, skill, amount, targetType)
    lib.notify(source, {
        title = 'Skills',
        description = ('Removed %d XP from %s for %s skill'):format(amount, GetPlayerName(target), skill),
        type = 'success'
    })
end)

lib.addCommand('setlevel', {
    help = 'Set level for a player\'s skill',
    params = {
        {
            name = 'target',
            help = 'Target player\'s server id'
        },
        {
            name = 'skill',
            type = 'string',
            help = 'Name of skill'
        },
        {
            name = 'level',
            type = 'number',
            help = 'Level to set'
        }
    },
    restricted = 'group.admin'
}, function(source, args)
    local skill = args.skill
    local level = args.level
    local target = args.target

    if not utils.validateSkillCommand(source, skill, target, level, true) then
        return
    end

    skills.setSkillLevel(target, skill, level)
    lib.notify(source, {
        title = 'Skills',
        description = ('Set %s skill to level %d for %s'):format(skill, level, GetPlayerName(target)),
        type = 'success'
    })
end)
