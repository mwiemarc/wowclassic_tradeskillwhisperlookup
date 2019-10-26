local TSWL_AddonName, TSWL = ...

TSWL.options = {}
TSWL.options.autocompleteData = {
    valueKeysHeader = {'{{first_index}}', '{{last_index}}', '{{num_results}}', '{{num_skills}}', '{{page}}', '{{num_pages}}', '{{request_cmd}}', '{{cmd}}', '{{skill_cur}}', '{{skill_max}}', '{{profession}}'},
    valueKeysSkill = {'{{index}}', '{{name}}', '{{item_link}}', '{{reagents}}', '{{num_craftable}}', '{{cd_timeleft}}'},
    valueKeysPaging = {'{{page}}', '{{next_page}}', '{{num_pages}}', '{{request_cmd}}'},
    reagents = {},
    tradeskills = {}
}

TSWL.options.professionConfigWidgets = {
    {
        name = 'cmd',
        label = TSWL.L['OPTIONS_LABEL_COMMAND']
    },
    {
        name = 'spellfix',
        label = TSWL.L['OPTIONS_LABEL_SPELLFIX']
    },
    {
        name = 'hideReagents',
        label = TSWL.L['OPTIONS_LABEL_HIDE_REAGENTS'],
        autocomplete = {
            dataKey = 'reagents',
            inputDelimiter = ';'
        }
    },
    {
        name = 'featured',
        label = TSWL.L['OPTIONS_LABEL_FEATURED'],
        autocomplete = {
            dataKey = 'tradeskills',
            inputDelimiter = ';'
        }
    },
    {
        label = TSWL.L['OPTIONS_HINT_FEATURED']
    },
    {
        name = 'responseHeader',
        label = TSWL.L['OPTIONS_LABEL_RESPONSE_HEADER'],
        autocomplete = {
            dataKey = 'valueKeysHeader',
            inputDelimiter = ' '
        }
    },
    {
        name = 'responseFooter',
        label = TSWL.L['OPTIONS_LABEL_RESPONSE_FOOTER'],
        autocomplete = {
            dataKey = 'valueKeysHeader',
            inputDelimiter = ' '
        }
    },
    {
        name = 'responseFeaturedHeader',
        label = TSWL.L['OPTIONS_LABEL_RESPONSE_FEATURED_HEADER'],
        autocomplete = {
            dataKey = 'valueKeysHeader',
            inputDelimiter = ' '
        }
    },
    {
        name = 'responseFeaturedFooter',
        label = TSWL.L['OPTIONS_LABEL_RESPONSE_FEATURED_FOOTER'],
        autocomplete = {
            dataKey = 'valueKeysHeader',
            inputDelimiter = ' '
        }
    },
    {
        label = TSWL.L['OPTIONS_HINT_VALUEKEYS_HEADER']
    },
    {
        name = 'responseHintPaging',
        label = TSWL.L['OPTIONS_LABEL_RESPONSE_HINT_PAGING'],
        autocomplete = {
            dataKey = 'valueKeysPaging',
            inputDelimiter = ' '
        }
    },
    {
        label = TSWL.L['OPTIONS_HINT_VALUEKEYS_PAGING']
    },
    {
        name = 'responseSkill',
        label = TSWL.L['OPTIONS_LABEL_RESPONSE_SKILL'],
        autocomplete = {
            dataKey = 'valueKeysSkill',
            inputDelimiter = ' '
        }
    },
    {
        name = 'responseSkillCraftable',
        label = TSWL.L['OPTIONS_LABEL_RESPONSE_SKILL_CRAFTABLE'],
        autocomplete = {
            dataKey = 'valueKeysSkill',
            inputDelimiter = ' '
        }
    },
    {
        label = TSWL.L['OPTIONS_HINT_VALUEKEYS_SKILL']
    },
    {
        name = 'responseHintNoResults',
        label = TSWL.L['OPTIONS_LABEL_RESPONSE_HINT_NO_RESULTS']
    },
    {
        name = 'responseHintDelayed',
        label = TSWL.L['OPTIONS_LABEL_RESPONSE_HINT_DELAYED']
    }
}

function TSWLOptionsPanel_ClickRemoveProfession()
    if TSWLOptionsPanel.selectedProfession == nil then
        PlaySound(847) -- igQuestFailed
        return
    end

    PlaySound(624) -- GAMEGENERICBUTTONPRESS

    local panel = _G['TSWLOptionsPanel']
    local professionPanel = _G['TSWLOptionsPanelProfessionConfigScrollFrameProfessionConfig']

    local newProfessions = {}

    for k, v in pairs(TSWL_CharacterConfig.professions) do
        if k ~= TSWLOptionsPanel.selectedProfession then
            newProfessions[k] = v
        end
    end

    TSWLOptionsPanel.selectedProfession = nil
    TSWL_CharacterConfig.professions = newProfessions

    professionPanel.refresh()
end

function TSWLOptionsPanel_ClickAddProfession()
    PlaySound(624) -- GAMEGENERICBUTTONPRESS

    TSWL.state.addProfession = true

    -- show popup, hide menu
    StaticPopup_Show('TSWL_OPTIONS_WAITFOR_PROFESSION_POPUP')
    InterfaceOptionsFrame_Show()
end

function TSWLOptionsPanel_ToggleAutocomplete(self)
    TSWL_CharacterConfig.enableAutocomplete = _G['TSWLOptionsPanelCheckAutocomplete']:GetChecked()
end

function TSWL.options.AddProfessionCallback(profName, err)
    if profName then
        PlaySound(624) -- GAMEGENERICBUTTONPRESS

        -- select new profession
        local professionPanel = _G['TSWLOptionsPanelScrollFrameProfessionConfig']
        TSWLOptionsPanel.selectedProfession = profName
        professionPanel.refresh()

        print('|cffffff00TS|r|cffff7effW|r|cffffff00L:|r |cff00ff00' .. string.gsub(TSWL.L['MSG_ADD_PROFESSION_SUCCESS'], '%{{profession}}', profName) .. '|r')
    else
        PlaySound(847) -- igQuestFailed

        print('|cffffff00TS|r|cffff7effW|r|cffffff00L:|r |cffff0000' .. TSWL.L['MSG_ADD_PROFESSION_ERR_EXISTS'] .. '|r')
    end

    -- hide popup, show menu
    StaticPopup_Hide('TSWL_OPTIONS_WAITFOR_PROFESSION_POPUP')

    InterfaceOptionsFrame_OpenToCategory('TradeSkillWhisperLookup')
    InterfaceOptionsFrame_OpenToCategory('TradeSkillWhisperLookup')
end

function TSWL.options.SetupPanel()
    local panel = _G['TSWLOptionsPanel']
    local professionPanel = _G['TSWLOptionsPanelScrollFrameProfessionConfig']
    local professionDropdown = _G['TSWLOptionsPanelProfessionDropDown']

    panel.selectedProfession = nil

    professionPanel:Hide()

    -- Setup the drop down menu
    function professionDropdown.Clicked(self, profName, arg2, checked)
        TSWLOptionsPanel.selectedProfession = profName
        professionPanel.refresh()
    end

    function professionDropdown.Menu()
        for k, v in pairs(TSWL_CharacterConfig.professions) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = k
            info.value = k
            info.checked = (k == TSWLOptionsPanel.selectedProfession)
            info.func = professionDropdown.Clicked
            info.arg1 = k

            UIDropDownMenu_AddButton(info)
        end
    end

    UIDropDownMenu_Initialize(professionDropdown, professionDropdown.Menu)
    UIDropDownMenu_SetWidth(professionDropdown, 200)
    UIDropDownMenu_JustifyText(professionDropdown, 'LEFT')
    UIDropDownMenu_SetText(professionDropdown, TSWLOptionsPanel.selectedProfession)

    -- Setup the per-profession configuration panel
    local function appendWidget(parent, child, rowPadding)
        child:SetParent(parent)

        if parent.lastWidget then
            child:SetPoint('TOPLEFT', parent.lastWidget, 'BOTTOMLEFT', 0, -rowPadding)
        else
            child:SetPoint('TOPLEFT', parent, 'TOPLEFT', 16, -16)
        end

        parent.lastWidget = child
    end

    local labelWidth = 160
    local widgetWidth = 380
    local columnPadding = 6
    local rowPadding = 24

    local function refreshWidget(widget)
        local widgetFrame = widget.widgetFrame

        if widgetFrame then
            local settingsTable = TSWL_CharacterConfig.professions[TSWLOptionsPanel.selectedProfession].config
            local settingsField = widget.name
            local value = settingsTable[settingsField]

            widgetFrame:SetText(value or '')
            widgetFrame:SetCursorPosition(0) -- Fix to scroll the text field to the left
            widgetFrame:ClearFocus()
        end
    end

    -- This is the method that actually updates the settings field in the RingMenu_ringConfig table
    local function widgetValueChanged(widget, value)
        local settingsTable = TSWL_CharacterConfig.professions[TSWLOptionsPanel.selectedProfession].config
        local settingsField = widget.name

        settingsTable[settingsField] = value

        -- Some config panel changes that should take immediate effect
        UIDropDownMenu_SetText(professionDropdown, TSWLOptionsPanel.selectedProfession)
    end

    local function widgetOnTextChanged(self, isUserInput) -- text value chaged
        if not isUserInput then
            return
        end

        local widget = self.widget
        local value = self:GetText()

        widgetValueChanged(widget, self:GetText()) -- save to config table
    end

    local function widgetOnKeyUp(self, key) -- accept autocomplete
        local widget = self.widget
        local value = self:GetText()

        if TSWL_CharacterConfig.enableAutocomplete and widget.autocomplete and TSWL.options.autocompleteData[widget.autocomplete.dataKey] then -- accept suggensting
            if key == 'TAB' or key == 'ENTER' or key == 'RETURN' then
                self:SetCursorPosition(string.len(value) + 1)
                self:HighlightText(0, 0)

                widgetValueChanged(widget, value) -- save to config table
            elseif key ~= 'BACKSPACE' and key ~= 'DELETE' then
                local ci = self:GetCursorPosition() -- save cursor pos
                local inputStr = string.sub(value, 1, ci) -- remove selection from query

                if string.sub(inputStr, -1) ~= widget.autocomplete.inputDelimiter then -- is valid cursor position and last char is not demiter
                    local splitArr = TSWL.util.stringSplit(inputStr, widget.autocomplete.inputDelimiter) -- get all substrings
                    local str = #splitArr > 0 and splitArr[#splitArr] and string.lower(splitArr[#splitArr]) or '' -- find last

                    if string.len(TSWL.util.stringTrim(str)) > 0 then -- has string to search
                        for i, v in ipairs(TSWL.options.autocompleteData[widget.autocomplete.dataKey]) do
                            if str == string.sub(string.lower(v), 1, string.len(str)) then -- find first match
                                self:Insert(string.sub(v, string.len(str) + 1)) -- insert suggestion
                                self:HighlightText(ci, ci + (string.len(v) - string.len(str))) -- select suggested inset
                                self:SetCursorPosition(ci) -- restore cursor pos
                                return
                            end
                        end
                    end
                end
            end

            widgetValueChanged(widget, self:GetText()) -- save to config table
        end
    end

    for i, widget in ipairs(TSWL.options.professionConfigWidgets) do
        if widget.name then -- options widget
            -- widget label
            local label = professionPanel:CreateFontString(professionPanel:GetName() .. 'Label' .. widget.name, 'ARTWORK', 'GameFontNormal')
            label:SetText(widget.label)
            label:SetWidth(labelWidth)
            label:SetJustifyH('LEFT')

            appendWidget(professionPanel, label, rowPadding) -- append label

            -- create option editbox
            local widgetFrame = CreateFrame('EditBox', professionPanel:GetName() .. 'Widget' .. widget.name, professionPanel, 'InputBoxTemplate')
            widgetFrame:SetPoint('LEFT', label, 'RIGHT', columnPadding, 0)
            widgetFrame:SetWidth(widgetWidth - 6)
            widgetFrame:SetHeight(20)
            widgetFrame:SetAutoFocus(false)

            widgetFrame:EnableKeyboard(true)
            widgetFrame:SetScript('OnKeyUp', widgetOnKeyUp)
            widgetFrame:SetScript('OnTextChanged', widgetOnTextChanged)

            if widgetFrame then
                if widget.tooltip then
                    widgetFrame.tooltipText = widget.tooltip
                end

                -- Establish cross-references
                widgetFrame.widget = widget
                widget.widgetFrame = widgetFrame
            end
        else -- text hint only
            local hint = professionPanel:CreateFontString(professionPanel:GetName() .. 'Hint' .. i, 'ARTWORK', 'GameFontNormal')
            hint:SetText(widget.label)
            hint:SetWidth(labelWidth + widgetWidth + columnPadding)
            hint:SetJustifyH('LEFT')

            appendWidget(professionPanel, hint, rowPadding)
        end
    end

    function professionPanel.refresh()
        UIDropDownMenu_SetText(professionDropdown, TSWLOptionsPanel.selectedProfession)

        if TSWLOptionsPanel.selectedProfession then
            -- update autocomplete values
            TSWL.options.autocompleteData.reagents = {}
            TSWL.options.autocompleteData.tradeskills = {}

            for k, v in pairs(TSWL_CharacterConfig.professions[TSWLOptionsPanel.selectedProfession].data.tradeskills) do
                table.insert(TSWL.options.autocompleteData.tradeskills, v.name)
                table.insert(TSWL.options.autocompleteData.tradeskills, TSWL.util.unescapeLink(v.link))

                for kk, vv in pairs(v.reagents) do
                    table.insert(TSWL.options.autocompleteData.reagents, vv.name)
                end

                for kk, vv in pairs(v.hiddenReagents) do
                    table.insert(TSWL.options.autocompleteData.reagents, vv.name)
                end
            end

            -- update frames
            professionPanel:Show()

            for i, widget in ipairs(TSWL.options.professionConfigWidgets) do
                refreshWidget(widget)
            end
        else
            professionPanel:Hide()
        end
    end

    _G['TSWLOptionsPanelCheckAutocomplete']:SetChecked(TSWL_CharacterConfig.enableAutocomplete) -- set autocomplete

    -- Display the current version in the title
    _G['TSWLOptionsPanelTitle']:SetText('TradeSkill|cffff7effWhisper|rLookup |cff888888v' .. GetAddOnMetadata('TradeSkillWhisperLookup', 'Version'))

    panel.name = 'TradeSkillWhisperLookup'
    panel.refresh = function(self)
        professionPanel.refresh()
    end

    InterfaceOptions_AddCategory(panel)

    for k, v in pairs(TSWL_CharacterConfig.professions) do -- preselect first profession
        if not TSWLOptionsPanel.selectedProfession then
            TSWLOptionsPanel.selectedProfession = k
            panel.refresh()
        end
    end
end

StaticPopupDialogs['TSWL_OPTIONS_WAITFOR_PROFESSION_POPUP'] = {
    text = '<TS|cffff7effW|rL>\n\n' .. TSWL.L['POPUP_MSG_ADD_PROFESSION'] .. '\n',
    button1 = 'OK',
    OnAccept = function()
        StaticPopup_Hide('TSWL_OPTIONS_WAITFOR_PROFESSION_POPUP')
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3
}
