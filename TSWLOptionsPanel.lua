local TSWL_AddonName, TSWL = ...

TSWL.options = {}

local autocompleteDataset = {
    valueKeysHeader = {'{{first_index}}', '{{last_index}}', '{{num_results}}', '{{num_tradeskills}}', '{{page}}', '{{num_pages}}', '{{request_cmd}}', '{{cmd}}', '{{skill_cur}}', '{{skill_max}}', '{{profession}}'},
    valueKeysSkill = {'{{index}}', '{{name}}', '{{item}}', '{{reagents}}', '{{num_craftable}}', '{{cd}}'},
    valueKeysPaging = {'{{page}}', '{{next_page}}', '{{num_pages}}', '{{request_cmd}}'},
    reagents = {},
    tradeskills = {}
}

local professionConfigWidgets = {
    {
        name = 'cmd',
        label = TSWL.L['OPTIONS_LABEL_COMMAND']
    },
    {
        name = 'spellfix',
        label = TSWL.L['OPTIONS_LABEL_SPELLFIX'],
        tooltip = TSWL.L['OPTIONS_TOOLTIP_SPELLFIX']
    },
    {
        name = 'hideReagents',
        label = TSWL.L['OPTIONS_LABEL_HIDE_REAGENTS'],
        tooltip = TSWL.L['OPTIONS_TOOLTIP_HIDE_REAGENTS'],
        autocomplete = {
            datasetKey = 'reagents',
            inputDelimiter = ';'
        }
    },
    {
        name = 'featured',
        label = TSWL.L['OPTIONS_LABEL_FEATURED'],
        tooltip = TSWL.L['OPTIONS_TOOLTIP_FEATURED'],
        autocomplete = {
            datasetKey = 'tradeskills',
            inputDelimiter = ';'
        }
    },
    {
        name = 'responseNoResults',
        label = TSWL.L['OPTIONS_LABEL_RESPONSE_NO_RESULTS']
    },
    {
        name = 'responseHeader',
        label = TSWL.L['OPTIONS_LABEL_RESPONSE_HEADER'],
        tooltip = TSWL.L['OPTIONS_TOOLTIP_RESPONSE_HEADER'],
        autocomplete = {
            datasetKey = 'valueKeysHeader',
            inputDelimiter = ' '
        }
    },
    {
        name = 'responseFooter',
        label = TSWL.L['OPTIONS_LABEL_RESPONSE_FOOTER'],
        tooltip = TSWL.L['OPTIONS_TOOLTIP_RESPONSE_HEADER'],
        autocomplete = {
            datasetKey = 'valueKeysHeader',
            inputDelimiter = ' '
        }
    },
    {
        name = 'responseFeaturedHeader',
        label = TSWL.L['OPTIONS_LABEL_RESPONSE_FEATURED_HEADER'],
        tooltip = TSWL.L['OPTIONS_TOOLTIP_RESPONSE_HEADER'],
        autocomplete = {
            datasetKey = 'valueKeysHeader',
            inputDelimiter = ' '
        }
    },
    {
        name = 'responseFeaturedFooter',
        label = TSWL.L['OPTIONS_LABEL_RESPONSE_FEATURED_FOOTER'],
        tooltip = TSWL.L['OPTIONS_TOOLTIP_RESPONSE_HEADER'],
        autocomplete = {
            datasetKey = 'valueKeysHeader',
            inputDelimiter = ' '
        }
    },
    {
        name = 'responseSkill',
        label = TSWL.L['OPTIONS_LABEL_RESPONSE_SKILL'],
        tooltip = TSWL.L['OPTIONS_TOOLTIP_RESPONSE_SKILL'],
        autocomplete = {
            datasetKey = 'valueKeysSkill',
            inputDelimiter = ' '
        }
    },
    {
        name = 'responseSkillCraftable',
        label = TSWL.L['OPTIONS_LABEL_RESPONSE_SKILL_CRAFTABLE'],
        tooltip = TSWL.L['OPTIONS_TOOLTIP_RESPONSE_SKILL'],
        autocomplete = {
            datasetKey = 'valueKeysSkill',
            inputDelimiter = ' '
        }
    },
    {
        name = 'responseHintPaging',
        label = TSWL.L['OPTIONS_LABEL_RESPONSE_HINT_PAGING'],
        tooltip = TSWL.L['OPTIONS_TOOLTIP_RESPONSE_HINT_PAGING'],
        autocomplete = {
            datasetKey = 'valueKeysPaging',
            inputDelimiter = ' '
        }
    },
    {
        name = 'responseHintDelay',
        label = TSWL.L['OPTIONS_LABEL_RESPONSE_HINT_DELAY'],
        tooltip = TSWL.L['OPTIONS_TOOLTIP_RESPONSE_HINT_DELAY']
    }
}

-- set tooltip for xml frames
_G['TSWLOptionsPanelCheckButtonAutocomplete'].tooltip = TSWL.L['OPTIONS_TOOLTIP_AUTOCOMPLETE']

-- global functions called by xml frames
function TSWLOptionsPanel_ShowTooltip(frame)
    GameTooltip:SetOwner(frame, 'ANCHOR_BOTTOMRIGHT', -(frame:GetWidth() + 8)) -- ANCHOR_RIGHT ANCHOR_CURSOR
    GameTooltip:SetText(frame.tooltip, 1.0, 1.0, 1.0, true)
    GameTooltip:Show()
end

function TSWLOptionsPanel_HideTooltip()
    GameTooltip:Hide()
end

function TSWLOptionsPanel_SetAutocomplete(self)
    TSWL_CharacterConfig.enableAutocomplete = _G['TSWLOptionsPanelCheckButtonAutocomplete']:GetChecked()
end

function TSWLOptionsPanel_ClickRemoveProfession()
    if TSWLOptionsPanel.selectedProfession == nil then
        PlaySound(847) -- igQuestFailed
        return
    end

    PlaySound(624) -- GAMEGENERICBUTTONPRESS

    local panel = _G['TSWLOptionsPanel']
    local professionPanel = _G['TSWLOptionsPanelScrollFrameProfessionConfig']

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
    StaticPopup_Show('TSWL_POPUP_ADD_PROFESSION')
    InterfaceOptionsFrame_Show()
end

function TSWL.options.AddProfessionCallback(profName, err)
    CloseTradeSkill() -- close tradeskill window
    CloseCraft() -- close craft window

    if profName then
        PlaySound(624) -- GAMEGENERICBUTTONPRESS

        -- select new profession
        local professionPanel = _G['TSWLOptionsPanelScrollFrameProfessionConfig']
        TSWLOptionsPanel.selectedProfession = profName
        professionPanel.refresh()

        print('|cffffff00TS|r|cffff7effW|r|cffffff00L:|r |cff00ff00' .. TSWL.L['MSG_ADD_PROFESSION_SUCCESS'] .. '|r')
    else
        PlaySound(847) -- igQuestFailed

        print('|cffffff00TS|r|cffff7effW|r|cffffff00L:|r |cffff0000' .. TSWL.L['MSG_ADD_PROFESSION_ERR_EXISTS'] .. '|r')
    end

    -- hide popup, show menu
    StaticPopup_Hide('TSWL_POPUP_ADD_PROFESSION')

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

            if widget.autocomplete then
                InlineAutocompleteLib:SetEditBoxValues(widgetFrame, autocompleteDataset[widget.autocomplete.datasetKey]) -- update autocomplete values
            end

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

        widgetValueChanged(widget, value)
    end

    local function widgetOnKeyUp(self, key)
        local widget = self.widget
        local value = self:GetText()

        widgetValueChanged(widget, value)
    end

    for i, widget in ipairs(professionConfigWidgets) do
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

        if widget.autocomplete then
            InlineAutocompleteLib:RegisterEditBox(widgetFrame, widget.autocomplete.inputDelimiter)
        end

        if widgetFrame then
            if widget.tooltip then
                widgetFrame.tooltip = widget.tooltip
                widgetFrame:SetScript('OnEnter', TSWLOptionsPanel_ShowTooltip)
                widgetFrame:SetScript('OnLeave', TSWLOptionsPanel_HideTooltip)
            end

            -- Establish cross-references
            widgetFrame.widget = widget
            widget.widgetFrame = widgetFrame
        end
    end

    function professionPanel.refresh()
        UIDropDownMenu_SetText(professionDropdown, TSWLOptionsPanel.selectedProfession)

        if TSWLOptionsPanel.selectedProfession then
            -- update autocomplete values
            autocompleteDataset.reagents = {}
            autocompleteDataset.tradeskills = {}

            local addedTradeSkills = {}
            local addedReagents = {}

            for k, v in pairs(TSWL_CharacterConfig.professions[TSWLOptionsPanel.selectedProfession].data.tradeskills) do
                if not addedTradeSkills[v.name] then
                    table.insert(autocompleteDataset.tradeskills, v.name)

                    addedTradeSkills[v.name] = true
                end

                if not addedTradeSkills[TSWL.util.linkToName(v.link)] then
                    table.insert(autocompleteDataset.tradeskills, TSWL.util.linkToName(v.link))

                    addedTradeSkills[TSWL.util.linkToName(v.link)] = true
                end

                for kk, vv in pairs(v.reagents) do
                    if not addedReagents[vv.name] then
                        table.insert(autocompleteDataset.reagents, vv.name)

                        addedReagents[vv.name] = true
                    end
                end
            end

            -- update frames
            professionPanel:Show()

            for i, widget in ipairs(professionConfigWidgets) do
                refreshWidget(widget)
            end
        else
            professionPanel:Hide()
        end
    end

    _G['TSWLOptionsPanelCheckButtonAutocomplete']:SetChecked(TSWL_CharacterConfig.enableAutocomplete) -- set autocomplete

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

StaticPopupDialogs['TSWL_POPUP_ADD_PROFESSION'] = {
    text = '|cffffff00TradeSkill|r|cffff7effWhisper|r|cffffff00Lookup|r\n\n\n' .. TSWL.L['POPUP_ADD_PROFESSION_TXT'] .. '\n',
    button1 = 'OK',
    OnAccept = function()
        StaticPopup_Hide('TSWL_POPUP_ADD_PROFESSION')
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3
}
