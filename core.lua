local TSWL_AddonName, TSWL = ...

TSWL.state = {}

local function BuildWhisperResponse(prof, query, page, skills)
    local resMsgs = {}
    local featured = false

    if #skills > 0 then
        if not query and not page and string.len(prof.config.featured) > 0 then -- response featured skills?
            featured = true
        end

        -- paging
        if not page then -- no page set -> is full list lookup or featured
            page = 1 -- default page
        end

        local perPage = 16 -- items per page (shouldn't be increased)
        local numPages = math.ceil(#skills / perPage) -- get page count
        local firstIndex = (page - 1) * perPage -- first skill index for page
        local lastIndex = firstIndex + perPage -- last skill index for page

        if lastIndex > #skills then -- page is not max size
            lastIndex = #skills
        end

        -- add header
        local headerStr = featured and prof.config.responseFeaturedHeader or prof.config.responseHeader

        headerStr = string.gsub(headerStr, '%{{first_index}}', tostring(firstIndex + 1))
        headerStr = string.gsub(headerStr, '%{{last_index}}', tostring(lastIndex))
        headerStr = string.gsub(headerStr, '%{{page}}', tostring(page))
        headerStr = string.gsub(headerStr, '%{{num_pages}}', tostring(numPages))
        headerStr = string.gsub(headerStr, '%{{num_results}}', tostring(#skills))
        headerStr = string.gsub(headerStr, '%{{num_tradeskills}}', tostring(#prof.data.tradeskills))
        headerStr = string.gsub(headerStr, '%{{cmd}}', prof.config.cmd)
        headerStr = string.gsub(headerStr, '%{{request_cmd}}', tostring(query and prof.config.cmd .. ' ' .. query or prof.config.cmd))
        headerStr = string.gsub(headerStr, '%{{skill_cur}}', tostring(prof.data.skillCur))
        headerStr = string.gsub(headerStr, '%{{skill_max}}', tostring(prof.data.skillMax))
        headerStr = string.gsub(headerStr, '%{{profession}}', prof.data.name)

        table.insert(resMsgs, headerStr)

        if #skills >= 8 then -- is large response show delay hint
            table.insert(resMsgs, prof.config.responseHintDelay)
        end

        local hideReagents = TSWL.util.stringSplit(prof.config.hideReagents, ';') -- get ignore reagnts as array

        -- add tradeskill in range
        for i, s in ipairs(skills) do
            if i > firstIndex and i <= lastIndex then -- paging offset
                local skillStr

                if s.numCraftable > 0 then -- add craftable count
                    skillStr = prof.config.responseSkillCraftable
                    skillStr = string.gsub(skillStr, '%{{num_craftable}}', s.numCraftable)
                else
                    skillStr = prof.config.responseSkill
                end

                skillStr = string.gsub(skillStr, '%{{index}}', tostring(i)) -- add item link
                skillStr = string.gsub(skillStr, '%{{name}}', s.name) -- add tradeskill name
                skillStr = string.gsub(skillStr, '%{{item}}', s.link) -- add item link

                local visReagents = TSWL.profession.GetVisibleReagents(s.reagents, hideReagents)
                local reagentsStr = ''

                -- add reagents
                for j, v in ipairs(visReagents) do -- add reagents to string
                    reagentsStr = reagentsStr .. (v.count .. 'x' .. v.name) -- build reagents str

                    if j < #visReagents then -- is not last
                        reagentsStr = reagentsStr .. '/'
                    end
                end

                skillStr = string.gsub(skillStr, '%{{reagents}}', reagentsStr) -- add reagents

                -- add cooldown timeleft
                local cdStr = ''

                if s.cd and s.cd > time() then
                    local cdMins = floor(((s.cd - time()) / 60) + 0.5)

                    if cdMins > 0 then -- has cooldown
                        cdStr = string.format('(%s %s)', TSWL.L['LOCALE_COOLDOWN_TIMELEFT_TXT'], (cdMins > 60) and (floor((cdMins / 60) + 0.5) .. ' ' .. TSWL.L['LOCALE_SHORT_HOURS']) or (cdMins .. ' ' .. TSWL.L['LOCALE_SHORT_MINUTES']))
                    end
                end

                skillStr = string.gsub(skillStr, '%{{cd}}', cdStr) -- replace cd timeleft with value or empty str

                table.insert(resMsgs, skillStr) -- insert reponse line
            end
        end

        -- add paging
        if #skills > lastIndex then
            local hintPagingStr = prof.config.responseHintPaging

            hintPagingStr = string.gsub(hintPagingStr, '%{{request_cmd}}', (query and prof.config.cmd .. ' ' .. query or prof.config.cmd))
            hintPagingStr = string.gsub(hintPagingStr, '%{{page}}', tostring(page))
            hintPagingStr = string.gsub(hintPagingStr, '%{{next_page}}', tostring(page + 1))
            hintPagingStr = string.gsub(hintPagingStr, '%{{num_pages}}', tostring(numPages))

            table.insert(resMsgs, hintPagingStr)
        end

        -- add footer if set
        local footerStr = featured and prof.config.responseFeaturedFooter or prof.config.responseFooter

        if string.len(footerStr) > 0 then
            footerStr = string.gsub(footerStr, '%{{first_index}}', tostring(firstIndex + 1))
            footerStr = string.gsub(footerStr, '%{{last_index}}', tostring(lastIndex))
            footerStr = string.gsub(footerStr, '%{{page}}', tostring(page))
            footerStr = string.gsub(footerStr, '%{{num_pages}}', tostring(numPages))
            footerStr = string.gsub(footerStr, '%{{num_results}}', tostring(#skills))
            footerStr = string.gsub(footerStr, '%{{num_tradeskills}}', tostring(#prof.data.tradeskills))
            footerStr = string.gsub(footerStr, '%{{cmd}}', prof.config.cmd)
            footerStr = string.gsub(footerStr, '%{{request_cmd}}', (query and prof.config.cmd .. ' ' .. query or prof.config.cmd))
            footerStr = string.gsub(footerStr, '%{{skill_cur}}', tostring(prof.data.skillCur))
            footerStr = string.gsub(footerStr, '%{{skill_max}}', tostring(prof.data.skillMax))
            footerStr = string.gsub(footerStr, '%{{profession}}', prof.data.name)

            table.insert(resMsgs, footerStr)
        end
    else
        table.insert(resMsgs, prof.config.responseNoResults) -- no transkills found
    end

    -- split overlong strings into multiple
    local mi = 1

    while mi <= #resMsgs do
        if string.len(resMsgs[mi]) > 254 then -- overlength msg
            table.insert(resMsgs, mi + 1, string.sub(resMsgs[mi], 255)) -- insert second substr behind
            resMsgs[mi] = string.sub(resMsgs[mi], 1, 254) -- cut down
        end

        mi = mi + 1
    end

    return resMsgs
end

local function ParseWhisperMessage(msg)
    local args = TSWL.util.stringSplit(TSWL.util.linkToName(msg))
    local cmd, query, page

    if #args == 1 or (#args == 2 and tonumber(args[2]) ~= nil) then -- if is cmd or cmd and page number
        cmd = TSWL.util.stringTrim(string.lower(tostring(args[1]))) -- first parameter is cmd
        page = tonumber(args[2]) ~= nil and tonumber(args[2]) or page -- get page if set

        return cmd, query, page
    end

    query = '' -- query is string
    page = 1 -- starting page for query

    -- get cmd, build query get page if set
    for i = 1, #args do
        if i == 1 then -- first arg is cmd
            cmd = TSWL.util.stringTrim(string.lower(tostring(args[1])))
        elseif i == #args then -- last arg can be page number
            if tonumber(args[i]) ~= nil then
                page = tonumber(args[i])
            else
                query = query .. ' ' .. args[i]
            end
        else
            query = query .. ' ' .. args[i]
        end
    end

    query = TSWL.util.stringTrim(query) -- trim

    return cmd, query, page
end

local function ProcessWhisperMessage(player, msg)
    local cmd, query, page = ParseWhisperMessage(msg) -- get possible parameters from whisper message

    if cmd then
        local prof = TSWL.profession.GetProfessionByCmd(cmd) -- get profession table

        if prof then
            local skills = TSWL.profession.GetTradeSkills(prof, query, page) -- get saved trandeskills based on filters query and page
            local res = BuildWhisperResponse(prof, query, page, skills) -- get response text lines

            for i, l in ipairs(res) do -- process response lines
                if player then -- if playername is set
                    ChatThrottleLib:SendChatMessage('BULK', 'TRADESKILL_WHISPER_LOOKUP_RESPONSE', l, 'WHISPER', 'Common', player) -- send whisper response
                else
                    print(l) -- print whisper response
                end
            end
        end
    end
end

local function MigrateSavedVariables()
    -- import config from prev. version and show hint
    if TSWL_Professions then
        -- migrate old config
        for k, v in pairs(TSWL_Professions) do
            TSWL_CharacterConfig.professions[k] = TSWL.util.tableDeepCopy(TSWL.defaultConfig.Profession)

            TSWL_CharacterConfig.professions[k].config.cmd = v.config.cmd or '!' .. string.lower(k)
            TSWL_CharacterConfig.professions[k].config.spellfix = v.config.txt_spellfix or TSWL_CharacterConfig.professions[k].config.spellfix
            TSWL_CharacterConfig.professions[k].config.hideReagents = v.config.txt_ignore_reagents or TSWL_CharacterConfig.professions[k].config.hideReagents -- replace pattern
            TSWL_CharacterConfig.professions[k].config.responseNoResults = v.config.txt_res_empty or TSWL_CharacterConfig.professions[k].config.responseNoResults
            TSWL_CharacterConfig.professions[k].config.responseHeader = string.gsub(v.config.txt_res_header, '%{{num_skills}}', '{{num_results}}') or TSWL_CharacterConfig.professions[k].config.responseHeader
            TSWL_CharacterConfig.professions[k].config.responseFooter = string.gsub(v.config.txt_res_footer, '%{{num_skills}}', '{{num_results}}') or TSWL_CharacterConfig.professions[k].config.resFeaturedFooter
            TSWL_CharacterConfig.professions[k].config.responseHintDelay = v.config.txt_res_hint_large or TSWL_CharacterConfig.professions[k].config.responseHintDelay
            TSWL_CharacterConfig.professions[k].config.responseHintPaging = string.gsub(v.config.txt_res_hint_paging, '%{{query_cmd}}', '{{request_cmd}}') or TSWL_CharacterConfig.professions[k].config.responseHintPaging
            TSWL_CharacterConfig.professions[k].config.responseSkill = string.gsub(v.config.txt_res_skill, '%{{item_link}}', '{{item}}') or TSWL_CharacterConfig.professions[k].config.responseSkill
            TSWL_CharacterConfig.professions[k].config.responseSkillCraftable = string.gsub(v.config.txt_res_skill_craftable, '%{{item_link}}', '{{item}}') or TSWL_CharacterConfig.professions[k].config.responseSkillCraftable

            TSWL_CharacterConfig.professions[k].data.name = k or TSWL_CharacterConfig.professions[k].data.name
            TSWL_CharacterConfig.professions[k].data.skillCur = v.data.skill_cur or TSWL_CharacterConfig.professions[k].data.skillCur
            TSWL_CharacterConfig.professions[k].data.skillMax = v.data.skill_max or TSWL_CharacterConfig.professions[k].data.skillMax
            TSWL_CharacterConfig.professions[k].data.tradeskills = v.data.tradeskills or TSWL_CharacterConfig.professions[k].data.tradeskills

            for i, vv in pairs(TSWL_CharacterConfig.professions[k].data.tradeskills) do
                TSWL.util.tableUpdate(TSWL_CharacterConfig.professions[k].data.tradeskills[i], TSWL.defaultConfig.ProfessionTradeSkill)
            end
        end

        TSWL_Professions = nil -- todo: remove saved variable in future versions

        -- show user messages and popup
        StaticPopup_Show('TSWL_POPUP_CONFIG_UPDATED')
    end

    if TSWL_CharacterConfig then -- move hidden reagents to reagents
        for k, v in pairs(TSWL_CharacterConfig.professions) do
            for i, vv in ipairs(v.data.tradeskills) do
                if vv.hiddenReagents then
                    for ii, vvv in ipairs(vv.hiddenReagents) do
                        table.insert(TSWL_CharacterConfig.professions[k].data.tradeskills[i].reagents, vvv)
                    end

                    TSWL_CharacterConfig.professions[k].data.tradeskills[i].hiddenReagents = nil
                end
            end
        end
    end
end

local function Init()
    TSWL.state.addProfession = false

    -- update saved variables
    TSWL_CharacterConfig = TSWL_CharacterConfig or {}
    TSWL.util.tableUpdate(TSWL_CharacterConfig, TSWL.defaultConfig.CharacterConfig)

    TSWL_CharacterConfig.professions = TSWL_CharacterConfig.professions or {}
    for k, v in pairs(TSWL_CharacterConfig.professions) do
        TSWL.util.tableUpdate(TSWL_CharacterConfig.professions[k], TSWL.defaultConfig.Profession)

        for i = 1, #TSWL_CharacterConfig.professions[k].data.tradeskills do
            TSWL_CharacterConfig.professions[k].data.tradeskills[i] = TSWL_CharacterConfig.professions[k].data.tradeskills[i] or {}
            TSWL.util.tableUpdate(TSWL_CharacterConfig.professions[k].data.tradeskills[i], TSWL.defaultConfig.ProfessionTradeSkill)

            for j = 1, #TSWL_CharacterConfig.professions[k].data.tradeskills[i].reagents do
                TSWL_CharacterConfig.professions[k].data.tradeskills[i].reagents[j] = TSWL_CharacterConfig.professions[k].data.tradeskills[i].reagents[j] or {}
                TSWL.util.tableUpdate(TSWL_CharacterConfig.professions[k].data.tradeskills[i].reagents[j], TSWL.defaultConfig.ProfessionTradeSkillReagent)
            end
        end
    end

    MigrateSavedVariables() -- migrate old configuration if exists
    TSWL.options.SetupPanel() -- setup options panel
end

-- core event handler
local function MainEventHandler(frame, event, ...)
    if event == 'TRADE_SKILL_UPDATE' then -- profession update
        if TSWL.state.addProfession then
            TSWL.profession.TryAddProfession()
        else
            TSWL.profession.TryUpdateProfessionData()
        end
    elseif event == 'CRAFT_UPDATE' then -- crafting profession update (enchanting)
        if TSWL.state.addProfession then
            TSWL.profession.TryAddProfession(true)
        else
            TSWL.profession.TryUpdateProfessionData(true)
        end
    elseif event == 'CHAT_MSG_WHISPER' then -- recieved whisper message
        local msg, name = ...

        ProcessWhisperMessage(name, msg)
    elseif event == 'PLAYER_LOGIN' then -- on player logon world
        for k, v in pairs(TSWL_CharacterConfig.professions) do -- profession loaded message
            print('|cffffff00TS|r|cffff7effW|r|cffffff00L loaded|r |cff00ff00' .. k .. '|r |cffffff00(|r|cffff7eff' .. v.config.cmd .. '|r|cffffff00)|r')
        end
    elseif event == 'ADDON_LOADED' then -- on init
        local name = ...

        if name == TSWL_AddonName then
            Init(name)
        end
    end
end

-- create coreframe and register events
local mainFrame = CreateFrame('Frame')
mainFrame:RegisterEvent('TRADE_SKILL_UPDATE')
mainFrame:RegisterEvent('CRAFT_UPDATE')
mainFrame:RegisterEvent('CHAT_MSG_WHISPER')
mainFrame:RegisterEvent('PLAYER_LOGIN')
mainFrame:RegisterEvent('ADDON_LOADED')
mainFrame:SetScript('OnEvent', MainEventHandler)

-- register slashcommand
SLASH_TSWL_SLASHCOMMAND1 = '/tswl'

function SlashCmdList.TSWL_SLASHCOMMAND(msg, editBox)
    if string.len(msg) > 0 then
        ProcessWhisperMessage(nil, msg) -- self test print
    else
        InterfaceOptionsFrame_OpenToCategory('TradeSkillWhisperLookup')
        InterfaceOptionsFrame_OpenToCategory('TradeSkillWhisperLookup')
    end
end

StaticPopupDialogs['TSWL_POPUP_CONFIG_UPDATED'] = {
    text = '|cffffff00TradeSkill|r|cffff7effWhisper|r|cffffff00Lookup|r\n\n\n' .. TSWL.L['POPUP_CONFIG_UPDATED_TXT'] .. '\n',
    button1 = 'OK',
    OnAccept = function()
        StaticPopup_Hide('TSWL_POPUP_CONFIG_UPDATED')
        InterfaceOptionsFrame_OpenToCategory('TradeSkillWhisperLookup')
        InterfaceOptionsFrame_OpenToCategory('TradeSkillWhisperLookup')
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3
}
