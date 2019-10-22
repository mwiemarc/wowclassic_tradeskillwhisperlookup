local TSWL_AddonName, TSWL = ...

TSWL.helpers = {}

function TSWL.helpers.IsCraftingProfession(spellid)
    local ids = {2259, 3101, 3464, 11611, 7411, 7412, 7413, 13920, 2018, 3100, 3538, 9785, 3908, 3909, 3910, 12180, 2108, 3104, 3811, 10662, 4036, 4037, 4038, 12656, 3273, 3274, 7924, 10846, 2550, 3102, 3413, 18260}

    for i, v in ipairs(ids) do
        if v == spellid then
            return true
        end
    end

    return false
end

function TSWL.helpers.IsCmdMessage(msg)
    return (string.sub(msg, 1, 1) == '!')
end

function TSWL.helpers.ParseWhisperMessage(msg)
    local args = TSWL.util.string_split(msg)
    local cmd, query, page = nil, '', 1

    if #args == 1 or (#args == 2 and tonumber(args[2]) ~= nil) then
        cmd = tostring(string.lower(args[1]))
        page = tonumber(args[2]) ~= nil and tonumber(args[2]) or page

        return cmd, nil, page
    end

    for i = 1, #args do
        if i == 1 then
            cmd = args[1]
        elseif i == #args then
            if tonumber(args[i]) ~= nil then
                page = tonumber(args[i])
            else
                query = query .. ' ' .. args[i]
            end
        else
            query = query .. ' ' .. args[i]
        end
    end

    cmd = string.lower(cmd)

    return cmd, query, page
end

function TSWL.helpers.GetProfessionNameByCmd(cmd)
    cmd = string.lower(cmd)

    for k, v in pairs(TSWL_Professions) do
        if string.lower(v.config.cmd) == cmd then
            return k
        end
    end

    return nil
end
