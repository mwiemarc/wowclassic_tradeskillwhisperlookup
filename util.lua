local TSWL_AddonName, TSWL = ...

TSWL.util = {}

-- shallow-copy a table
function TSWL.util.tableShallowCopy(t)
    local copy = {}

    for k, v in pairs(t) do
        copy[k] = v
    end

    return copy
end

-- deep-copy a table
function TSWL.util.tableDeepCopy(t)
    local copy = {}

    if type(t) == 'table' then
        for k, v in pairs(t) do
            copy[TSWL.util.tableDeepCopy(k)] = TSWL.util.tableDeepCopy(v)
        end
    else
        copy = t
    end

    return copy
end

-- copies fields from defaultConfig to t but only if they are currently nil in t
function TSWL.util.tableUpdate(t, defaultConfig)
    for k, v in pairs(defaultConfig) do
        if t[k] == nil then
            t[k] = TSWL.util.tableDeepCopy(v)
        end
    end
end

-- trim spaces at start and trail
function TSWL.util.stringTrim(str)
    return str:match('^%s*(.-)%s*$')
end

-- do string.match for string array
function TSWL.util.stringMatchArray(str, arr)
    for i, v in ipairs(arr) do
        if string.match(string.lower(str), string.lower(v)) then
            return true
        end
    end

    return false
end

-- split string by delimiter char (utf8 safe)
function TSWL.util.stringSplit(str, delimiter)
    local list = {}
    local tmpStr = ''

    if delimiter == nil then
        delimiter = ' '
    end

    for c in str:gmatch('[%z\1-\127\194-\244][\128-\191]*') do
        if c == delimiter then
            if tmpStr ~= '' then
                table.insert(list, tmpStr)
                tmpStr = ''
            end
        else
            tmpStr = tmpStr .. c
        end
    end

    if tmpStr ~= '' then
        table.insert(list, tmpStr)
    end

    return list
end

-- split string by newline (\n)
function TSWL.util.stringSplitNewline(str)
    local strLines = {}

    for line in str:gmatch('([^\n]*)\n?') do
        local ltrim = line:match('^%s*(.-)%s*$')

        if string.len(ltrim) > 0 then
            table.insert(strLines, ltrim)
        end
    end

    return strLines
end

-- escpae chat link returns display string
function TSWL.util.unescapeLink(str)
    str = tostring(str)

    str = gsub(str, '|c........', '') -- Remove color start.
    str = gsub(str, '|r', '') -- Remove color end.
    str = gsub(str, '|H.-|h(.-)|h', '%1') -- Remove links.
    str = gsub(str, '|T.-|t', '') -- Remove textures.
    str = gsub(str, '{.-}', '') -- Remove raid target icons.

    return str
end

-- escpae chat link returns display string
function TSWL.util.linkToName(str)
    str = TSWL.util.unescapeLink(str)
    str = string.gsub(str, '%[', '') -- remove opening bracket
    str = string.gsub(str, '%]', '') -- remove closing bracked

    return str
end
