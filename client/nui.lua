local conf = require 'config'

local visible = false

RegisterCommand('skills', function()
    visible = not visible
    local skills = visible and lib.callback.await('ss_skills:server:getSkills', false) or nil
    if skills and next(skills) then
        table.sort(skills, function(a, b)
            if a.level == b.level then
                return a.xp > b.xp
            else
                return a.level > b.level
            end
        end)
    end

    local data = {
        visible = visible,
        title = 'My Skills',
        playerSkills = skills
    }

    SendNUIMessage({
        action = 'showSkills',
        data = data
    })

    SetNuiFocus(visible, visible)
end, false)

RegisterCommand('gangskills', function()
    visible = not visible
    local skills = visible and lib.callback.await('ss_skills:server:getGangSkills', false) or nil
    if skills and next(skills) then
        table.sort(skills, function(a, b)
            if a.level == b.level then
                return a.xp > b.xp
            else
                return a.level > b.level
            end
        end)
    end

    local data = {
        visible = visible,
        title = 'Gang Skills',
        playerSkills = skills
    }

    SendNUIMessage({
        action = 'showSkills',
        data = data
    })

    SetNuiFocus(visible, visible)
end, false)

RegisterNUICallback('hideSkills', function(_, cb)
    visible = false
    SetNuiFocus(false, false)
    cb({})
end)

--RegisterKeyMapping('skills', 'Show Skills View', 'keyboard', conf.UIHotkey)
