local TSWL_AddonName, TSWL = ...

TSWL.util = {}

-- shallow-copy a table
function TSWL.util.table_shallow_copy(t)
    local copy = {}
    for k, v in pairs(t) do
        copy[k] = v
    end
    return copy
end

-- deep-copy a table
function TSWL.util.table_deep_copy(t)
    local copy = {}
    if type(t) == 'table' then
        for k, v in pairs(t) do
            copy[TSWL.util.table_deep_copy(k)] = TSWL.util.table_deep_copy(v)
        end
    else
        copy = t
    end
    return copy
end

-- copies fields from defaults to t but only if they are currently nil in t
function TSWL.util.table_update(t, defaults)
    for k, v in pairs(defaults) do
        if t[k] == nil then
            t[k] = TSWL.util.table_deep_copy(v)
        end
    end
end

-- trim spaces at start and trail
function TSWL.util.string_trim(str)
    return str:match('^%s*(.-)%s*$')
end

-- do string.match for string array
function TSWL.util.string_match_array(str, arr)
    for i, v in ipairs(arr) do
        if string.match(string.lower(str), string.lower(v)) then
            return true
        end
    end

    return false
end

-- split string by delimiter char (utf8 safe)
function TSWL.util.string_split(str, delimiter)
    local substr = {}
    local tmpstr = ''

    if delimiter == nil then
        delimiter = ' '
    end

    for c in str:gmatch('[%z\1-\127\194-\244][\128-\191]*') do
        if c == delimiter then
            if tmpstr ~= '' then
                table.insert(substr, tmpstr:match('^%s*(.-)%s*$'))
                tmpstr = ''
            end
        else
            tmpstr = tmpstr .. c
        end
    end

    if tmpstr ~= '' then
        table.insert(substr, tmpstr:match('^%s*(.-)%s*$'))
    end

    return substr
end

-- split string by newline (\n)
function TSWL.util.string_split_newline(str)
    local str_lines = {}

    for line in str:gmatch('([^\n]*)\n?') do
        local ltrim = line:match('^%s*(.-)%s*$')

        if string.len(ltrim) > 0 then
            table.insert(str_lines, ltrim)
        end
    end

    return str_lines
end
