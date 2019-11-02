InlineAutocompleteLib = {}
InlineAutocompleteLib.version = '0.0.2-alpha'

local editBoxes = {}

local function FindLast(haystack, needle)
    local i = haystack:match('.*' .. needle .. '()')

    if i then
        return i - 1
    end

    return 0
end

local function MatchFirstValue(value, values)
    value = string.lower(value)

    if string.len(value) > 0 then
        for i, v in ipairs(values) do
            if value == string.sub(string.lower(v), 1, string.len(value)) then
                return v
            end
        end
    end

    return nil
end

local function MatchNextValue(value, lastMatch, values)
    value = string.lower(value)
    lastMatch = string.lower(lastMatch)

    if string.len(value) > 0 then
        local match = false

        for i, v in ipairs(values) do
            if not match and string.lower(v) == lastMatch then
                match = true
            elseif match and string.sub(string.lower(v), 1, string.len(value)) == value then
                return v
            end
        end
    end

    return nil
end

local function MatchPrevValue(value, lastMatch, values)
    value = string.lower(value)
    lastMatch = string.lower(lastMatch)

    if string.len(value) > 0 then
        local match = false

        for i = #values, 1, -1 do
            if match then
                if string.sub(string.lower(values[i]), 1, string.len(value)) == value then
                    return values[i]
                end
            elseif string.lower(values[i]) == lastMatch then
                match = true
            end
        end
    end

    return nil
end

local function OnKeyUp(frame, key)
    local alt = IsAltKeyDown()
    local ctrl = IsControlKeyDown()
    local c = editBoxes[frame:GetName()]

    if c and (string.len(key) == 1 or key == 'TAB' or key == 'ENTER' or (alt and ctrl)) then
        if #c.values > 0 then
            local txt = c.frame:GetText()
            local cur = c.frame:GetCursorPosition()
            local start = FindLast(string.sub(txt, 1, cur), '%' .. c.delimiter) + 1
            local stop = string.find(txt, c.delimiter, cur + 1)
            local match

            stop = stop and stop or string.len(txt)

            if key == 'ENTER' or (key == 'TAB' and ctrl) then -- complete
                c.frame:HighlightText(0, 0)
                c.frame:SetCursorPosition(stop)
            elseif key == 'TAB' then -- loop through values
                local search = string.sub(txt, start, cur)
                local fullSearch = string.sub(txt, start, stop)

                if IsShiftKeyDown() then -- shift to match prev
                    match = MatchPrevValue(search, fullSearch, c.values)
                else
                    match = MatchNextValue(search, fullSearch, c.values)
                end
            elseif (not alt and not ctrl) or (alt and ctrl) then -- try find value
                local search = string.sub(txt, start, cur)

                match = MatchFirstValue(search, c.values)
            end

            if match then
                local insert = string.sub(match, -(string.len(match) - (cur - start) - 1))

                c.frame:Insert(insert)
                c.frame:HighlightText(cur, cur + (string.len(insert)))
                c.frame:SetCursorPosition(cur)
            end

            if c.script and type(c.script) == 'function' then -- call orginal event listener
                c.script(frame, key)
            end
        end
    end
end

function InlineAutocompleteLib:RegisterEditBox(editBoxFrame, inputDelimiter)
    editBoxes[editBoxFrame:GetName()] = {
        frame = editBoxFrame,
        values = {},
        delimiter = inputDelimiter,
        script = editBoxFrame:GetScript('OnKeyUp')
    }

    editBoxFrame:EnableKeyboard(true)
    editBoxFrame:SetScript('OnKeyUp', OnKeyUp)
end

function InlineAutocompleteLib:UnregisterEditBox(editBoxFrame)
    if editBoxes[editBoxFrame:GetName()] then
        editBoxFrame:SetScript('OnKeyUp', editBoxes[editBoxFrame:GetName()].script) -- revert orginal event listener

        editBoxes[editBoxFrame:GetName()] = nil
    end
end

function InlineAutocompleteLib:SetEditBoxValues(frame, values)
    if editBoxes[frame:GetName()] then
        editBoxes[frame:GetName()].values = values
    end
end
