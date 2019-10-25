local TSWL_AddonName, TSWL = ...

TSWL.options = {}

TSWL.options.professionConfigWidgets = {
    {
        name = 'cmd',
        label = TSWL.L['TXT_CONFIG_COMMAND']
    },
    {
        name = 'txt_spellfix',
        label = TSWL.L['TXT_CONFIG_SPELLFIX']
    },
    {
        name = 'txt_ignore_reagents',
        label = TSWL.L['TXT_CONFIG_IGNORE_REAGENTS']
    },
    {
        name = 'txt_res_header',
        label = TSWL.L['TXT_CONFIG_RESPONSE_HEADER']
    },
    {
        name = 'txt_res_empty',
        label = TSWL.L['TXT_CONFIG_RESPONSE_EMPTY']
    },
    {
        name = 'txt_res_footer',
        label = TSWL.L['TXT_CONFIG_RESPONSE_FOOTER']
    },
    {
        name = 'txt_res_hint_large',
        label = TSWL.L['TXT_CONFIG_RESPONSE_HINT_LARGE']
    },
    {
        name = 'txt_res_hint_paging',
        label = TSWL.L['TXT_CONFIG_RESPONSE_HINT_PAGING']
    },
    {
        name = 'txt_res_skill',
        label = TSWL.L['TXT_CONFIG_RESPONSE_SKILL']
    },
    {
        name = 'txt_res_skill_craftable',
        label = TSWL.L['TXT_CONFIG_RESPONSE_SKILL_CRAFTABLE']
    }
}

function TSWLOptionsPanel_ClickRemoveProfession()
    if TSWLOptionsPanel.selected_profession == nil then
        PlaySound(847) -- igQuestFailed
        return
    end

    PlaySound(624) -- GAMEGENERICBUTTONPRESS

    local panel = _G['TSWLOptionsPanel']
    local professionPanel = _G['TSWLOptionsPanelProfessionConfig']

    local new_professions = {}

    for k, v in pairs(TSWL_Professions) do
        if k ~= TSWLOptionsPanel.selected_profession then
            new_professions[k] = v
        end
    end

    TSWLOptionsPanel.selected_profession = nil
    TSWL_Professions = new_professions

    professionPanel.refresh()
end

function TSWLOptionsPanel_ClickAddProfession()
    PlaySound(624) -- GAMEGENERICBUTTONPRESS

    TSWL.core.state.add_profession = true

    -- show popup, hide menu
    StaticPopup_Show('TSWL_OPTIONS_WAITFOR_PROFESSION_POPUP')
    InterfaceOptionsFrame_Show()
end

function TSWL.options.AddProfessionCallback(prof_name, err)
    if prof_name then
        -- select new profession
        local professionPanel = _G['TSWLOptionsPanelProfessionConfig']
        TSWLOptionsPanel.selected_profession = prof_name
        professionPanel.refresh()

        print('TSWL: ' .. string.gsub(TSWL.L['MSG_PROFESSION_ADDED'], '%{{profession}}', prof_name))
    else
        print('TSWL: ' .. TSWL.L['MSG_PROFESSION_ADDED_FAIL'] .. ': ' .. err)
    end

    -- hide popup, show menu
    StaticPopup_Hide('TSWL_OPTIONS_WAITFOR_PROFESSION_POPUP')

    InterfaceOptionsFrame_OpenToCategory('TradeSkillWhisperLookup')
    InterfaceOptionsFrame_OpenToCategory('TradeSkillWhisperLookup')
end

function TSWL.options.SetupPanel()
    local panel = _G['TSWLOptionsPanel']
    local professionPanel = _G['TSWLOptionsPanelProfessionConfig']
    local professionDropdown = _G['TSWLOptionsPanelProfessionDropDown']

    -- Setup the drop down menu
    panel.selected_profession = nil
    professionPanel:Hide()

    function professionDropdown.Clicked(self, prof_name, arg2, checked)
        TSWLOptionsPanel.selected_profession = prof_name
        professionPanel.refresh()
    end

    function professionDropdown.Menu()
        for k, v in pairs(TSWL_Professions) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = k
            info.value = k
            info.checked = (k == TSWLOptionsPanel.selected_profession)
            info.func = professionDropdown.Clicked
            info.arg1 = k

            UIDropDownMenu_AddButton(info)
        end
    end

    UIDropDownMenu_Initialize(professionDropdown, professionDropdown.Menu)
    UIDropDownMenu_SetWidth(professionDropdown, 200)
    UIDropDownMenu_JustifyText(professionDropdown, 'LEFT')
    UIDropDownMenu_SetText(professionDropdown, TSWLOptionsPanel.selected_profession)

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
    local columnPadding = 0
    local rowPadding = 24

    local function refreshWidget(widget)
        local widgetFrame = widget.widgetFrame

        if widgetFrame then
            local settingsTable = TSWL_Professions[TSWLOptionsPanel.selected_profession].config
            local settingsField = widget.name
            local value = settingsTable[settingsField]

            widgetFrame:SetText(value or '')
            widgetFrame:SetCursorPosition(0) -- Fix to scroll the text field to the left
            widgetFrame:ClearFocus()
        end
    end

    -- This is the method that actually updates the settings field in the RingMenu_ringConfig table
    local function widgetChanged(widget, value)
        local settingsTable = TSWL_Professions[TSWLOptionsPanel.selected_profession].config
        local settingsField = widget.name

        settingsTable[settingsField] = value

        -- Some config panel changes that should take immediate effect
        UIDropDownMenu_SetText(professionDropdown, TSWLOptionsPanel.selected_profession)
    end

    local function textOnValueChanged(self, isUserInput)
        if not isUserInput then
            return
        end

        local widget = self.widget
        local value = self:GetText()

        widgetChanged(widget, value)
    end

    for _, widget in ipairs(TSWL.options.professionConfigWidgets) do
        local label = professionPanel:CreateFontString(professionPanel:GetName() .. 'Label' .. widget.name, 'ARTWORK', 'GameFontNormal')

        label:SetText(widget.label)
        label:SetWidth(labelWidth)
        label:SetJustifyH('LEFT')

        appendWidget(professionPanel, label, rowPadding)

        local widgetFrame = CreateFrame('EditBox', professionPanel:GetName() .. 'Widget' .. widget.name, professionPanel, 'InputBoxTemplate')
        widgetFrame:SetPoint('LEFT', label, 'RIGHT', columnPadding + 6, 0)
        widgetFrame:SetWidth(widgetWidth - 6)
        widgetFrame:SetHeight(20)
        widgetFrame:SetAutoFocus(false)

        widgetFrame:SetScript('OnTextChanged', textOnValueChanged)

        if widgetFrame then
            if widget.tooltip then
                widgetFrame.tooltipText = widget.tooltip
            end

            -- Establish cross-references
            widgetFrame.widget = widget
            widget.widgetFrame = widgetFrame
        end
    end

    function professionPanel.refresh()
        UIDropDownMenu_SetText(professionDropdown, TSWLOptionsPanel.selected_profession)

        if TSWLOptionsPanel.selected_profession then
            professionPanel:Show()

            for _, widget in ipairs(TSWL.options.professionConfigWidgets) do
                refreshWidget(widget)
            end
        else
            professionPanel:Hide()
        end
    end

    -- Display the current version in the title
    local version = GetAddOnMetadata('TradeSkillWhisperLookup', 'Version')
    local titleLabel = _G['TSWLOptionsPanelTitle']
    titleLabel:SetText('TradeSkillWhisperLookup |cFF888888v' .. version)

    panel.name = 'TradeSkillWhisperLookup'
    panel.refresh = function(self)
        professionPanel.refresh()
    end

    InterfaceOptions_AddCategory(panel)
end

StaticPopupDialogs['TSWL_OPTIONS_WAITFOR_PROFESSION_POPUP'] = {
    text = '<TSWL>\n\n' .. TSWL.L['MSG_PROFESSION_ADD_POPUP'] .. '\n',
    button1 = 'OK',
    OnAccept = function()
        StaticPopup_Hide('TSWL_OPTIONS_WAITFOR_PROFESSION_POPUP')
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3
}
