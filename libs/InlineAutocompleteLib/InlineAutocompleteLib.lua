local IACLIB_VERSION = '0.0.3-alpha'

-- version check
if _G['IACLIB_VERSION'] then
    local digs, _digs = {}, {}

    -- get digs vom version string
    for d in IACLIB_VERSION:gmatch('[0-9]+') do
        table.insert(digs, tonumber(d))
    end

    for d in _G['IACLIB_VERSION']:gmatch('[0-9]+') do
        table.insert(_digs, tonumber(d))
    end

    -- compare check version numbers
    if _digs[1] > digs[1] or _digs[2] > digs[2] or _digs[3] > digs[3] then
        return -- greater version number found, do not load
    end

    print('|cffff0000InlineAutocompleteLib: A older version is found, this could cause some issues|r')
    print('|cffff0000InlineAutocompleteLib: Please check your addons for updates or replace libraries in your addons with at least |r|cff00ff00v' .. IACLIB_VERSION .. '|r')
end

_G['IACLIB_VERSION'] = IACLIB_VERSION -- set loaded version

InlineAutocompleteLib = {} -- create and init global object

-- todo: make bindings local for editboxes or leave them global?
InlineAutocompleteLib.bindings = {}

-- default bindings
InlineAutocompleteLib.bindings.autocomplete = 'TAB'
InlineAutocompleteLib.bindings.nextSuggestion = 'SHIFT+TAB'
InlineAutocompleteLib.bindings.prevSuggestion = 'CTRL+TAB'
InlineAutocompleteLib.bindings.disable = ''

local editBoxes = {} -- registered frames are saved here with specific values

local function FindLastIndex(haystack, needle) -- get index of last matching char in string
    local i = haystack:match('.*' .. needle .. '()')

    return i and (i - 1) or 0
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
    local box = editBoxes[frame:GetName()]

    if InlineAutocompleteLib.enabled then
        if box and #box.values > 0 then -- has values
            local shift = IsShiftKeyDown()
            local ctrl = IsControlKeyDown()
            local alt = IsAltKeyDown()
            local altgr = (ctrl and alt) -- used for some special chars

            -- check for disabled key down
            if not ((InlineAutocompleteLib.bindings.disable == 'SHIFT' and shift) or (InlineAutocompleteLib.bindings.disable == 'CTRL' and (ctrl and not altgr)) or (InlineAutocompleteLib.bindings.disable == 'ALT' and (alt and not altgr))) then
                local mkey = key

                mkey = shift and 'SHIFT+' .. mkey or mkey
                mkey = ctrl and 'CTRL+' .. mkey or mkey
                mkey = alt and 'ALT+' .. mkey or mkey

                print(mkey, InlineAutocompleteLib.bindings.prevSuggestion)

                if string.len(key) == 1 or mkey == InlineAutocompleteLib.bindings.autocomplete or mkey == InlineAutocompleteLib.bindings.nextSuggestion or mkey == InlineAutocompleteLib.bindings.prevSuggestion then
                    local txt = box.frame:GetText()
                    local cur = box.frame:GetCursorPosition()
                    local start = FindLastIndex(string.sub(txt, 1, cur), '%' .. box.delimiter) + 1 -- find last delimiter before cursor
                    local stop = string.find(txt, box.delimiter, cur + 1) or string.len(txt) -- find first delimiter behind cursor

                    local search = string.sub(txt, start, cur)
                    local fullSearch = string.sub(txt, start, stop)
                    local match = nil

                    if mkey == InlineAutocompleteLib.bindings.autocomplete then
                        box.frame:HighlightText(0, 0) -- unhighlight
                        box.frame:SetCursorPosition(stop) -- set cursor to delimiter pos
                    elseif mkey == InlineAutocompleteLib.bindings.nextSuggestion then
                        match = MatchNextValue(search, fullSearch, box.values)
                    elseif mkey == InlineAutocompleteLib.bindings.prevSuggestion then
                        match = MatchPrevValue(search, fullSearch, box.values)
                    elseif not (ctrl and not altgr) then -- prevent autocomplete on copy, paste...
                        match = MatchFirstValue(search, box.values)
                    end

                    if match then -- has matching value
                        local insert = string.sub(match, -(string.len(match) - (cur - start) - 1)) -- only insert whats not already typed in

                        box.frame:Insert(insert)
                        box.frame:HighlightText(cur, cur + (string.len(insert))) -- hightlight insert
                        box.frame:SetCursorPosition(cur) -- return cursor to last position
                    end
                end
            end
        end
    end

    -- call orginal event listener function
    if box and type(box.onKeyUp) == 'function' then
        box.onKeyUp(frame, key)
    end
end

-- all uppercase: [modifier+] key, [modifier+] key, [modifier+] key, modifier
function InlineAutocompleteLib:SetBindings(autocompleteKey, nextSuggestionKey, prevSuggestionKey, disableKey)
    InlineAutocompleteLib.bindings = {
        autocomplete = autocompleteKey,
        nextSuggestion = nextSuggestionKey,
        prevSuggestion = prevSuggestionKey,
        disable = disableKey
    }
end

function InlineAutocompleteLib:RegisterEditBox(editBoxFrame, inputDelimiter)
    editBoxes[editBoxFrame:GetName()] = {
        frame = editBoxFrame,
        values = {},
        delimiter = inputDelimiter or ' ', -- space is default delimiter
        onKeyUp = editBoxFrame:GetScript('OnKeyUp')
    }

    editBoxFrame:EnableKeyboard(true)
    editBoxFrame:SetScript('OnKeyUp', OnKeyUp)
end

function InlineAutocompleteLib:UnregisterEditBox(editBoxFrame)
    if editBoxes[editBoxFrame:GetName()] then
        editBoxFrame:SetScript('OnKeyUp', editBoxes[editBoxFrame:GetName()].onKeyUp) -- revert orginal event listener or set to nil

        editBoxes[editBoxFrame:GetName()] = nil
    end
end

function InlineAutocompleteLib:SetEditBoxValues(frame, values)
    if editBoxes[frame:GetName()] then
        editBoxes[frame:GetName()].values = values
    end
end

InlineAutocompleteLib.enabled = true
