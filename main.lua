local TSWL_AddonName, TSWL = ...

TSWL.main = {}

TSWL.main.state = {
    add_profession = false
}

function TSWL.main.AddProfession()
    local prof_name, skill_cur, skill_max = GetTradeSkillLine()

    if
        prof_name == TSWL.L['PROFESSION_NAME_ALCHEMY'] or prof_name == TSWL.L['PROFESSION_NAME_BLACKSMITHING'] or prof_name == TSWL.L['PROFESSION_NAME_ENCHANTING'] or prof_name == TSWL.L['PROFESSION_NAME_ENGINEERING'] or
            prof_name == TSWL.L['PROFESSION_NAME_LEATHERWORKING'] or
            prof_name == TSWL.L['PROFESSION_NAME_TAILORING'] or
            prof_name == TSWL.L['PROFESSION_NAME_COOKING'] or
            prof_name == TSWL.L['PROFESSION_NAME_FIRSTAID']
     then
        if not TSWL_Professions[prof_name] then
            TSWL_Professions[prof_name] = TSWL.util.table_deep_copy(TSWL.defaults.Profession)
            TSWL_Professions[prof_name].config.cmd = '!' .. string.lower(prof_name)

            TSWL.main.UpdateProfessionData() -- update data

            print('TSWL: ' .. string.gsub(TSWL.L['MSG_PROFESSION_ADDED'], '%{{profession}}', prof_name))

            TSWL.options.AddProfessionCallback(prof_name)
        else
            TSWL.options.AddProfessionCallback(nil)
        end
    else
        TSWL.options.AddProfessionCallback(nil)
    end
end

function TSWL.main.UpdateProfessionData()
    local prof_name, skill_cur, skill_max = GetTradeSkillLine()

    if TSWL_Professions[prof_name] then
        TSWL_Professions[prof_name].data.skill_cur = skill_cur
        TSWL_Professions[prof_name].data.skill_max = skill_max
        TSWL_Professions[prof_name].data.tradeskills = {} -- reinit saved skills

        local ignore_reagents = TSWL.util.string_split(TSWL_Professions[prof_name].config.txt_ignore_reagents, ';')

        for i = 1, GetNumTradeSkills() do
            local sname, kind, num = GetTradeSkillInfo(i)
            local lname = string.lower(sname)
            local skill = {
                name = sname,
                num_craftable = num,
                reagents = {}
            }

            if kind and kind ~= 'header' and kind ~= 'subheader' then -- is item
                skill.cd = GetTradeSkillCooldown(i) -- get cd

                -- get reagents
                for j = 1, GetTradeSkillNumReagents(i) do
                    local reagent_name, _, reagent_count, player_reagent_count = GetTradeSkillReagentInfo(i, j)
                    local reagent = {
                        name = reagent_name,
                        count = reagent_count
                    }

                    -- save reagent
                    if reagent_name then
                        if #ignore_reagents > 0 then
                            if not TSWL.util.string_match_array(reagent_name, ignore_reagents) then -- check for ignore reagent
                                table.insert(skill.reagents, reagent)
                            end
                        else
                            table.insert(skill.reagents, reagent)
                        end
                    end
                end

                -- get itemlink and save
                local link = GetTradeSkillItemLink(i)

                if not link then
                    link = skill.name
                end

                skill.link = link
                table.insert(TSWL_Professions[prof_name].data.tradeskills, skill) -- save skill
            end
        end
    end
end

function TSWL.main.GetTradeSkills(prof_name, query)
    -- select all
    if not query then
        return TSWL_Professions[prof_name].data.tradeskills
    end

    local skills = {}

    -- fix misspells
    local spellfix = TSWL.util.string_split(TSWL_Professions[prof_name].config.txt_spellfix, ';')

    for i, v in ipairs(spellfix) do
        local sf_split = TSWL.util.string_split(v, '=')

        if string.match(string.lower(sf_split[1]), string.lower(query)) then
            query = string.lower(sf_split[2])
        end
    end

    for i, s in ipairs(TSWL_Professions[prof_name].data.tradeskills) do
        if string.match(string.lower(s.name), string.lower(query)) then
            table.insert(skills, s)
        end
    end

    return skills
end

function TSWL.main.BuildWhisperResponse(prof_name, skills, page, query_cmd)
    local res_lines = {}

    if #skills > 0 then
        -- paging
        page = page - 1

        local per_page = 15
        local num_pages = math.ceil(#skills / per_page)
        local first_index = (page * per_page)
        local last_index = first_index + per_page

        if last_index > #skills then
            last_index = #skills
        end

        local line

        -- add header
        line = TSWL_Professions[prof_name].config.txt_res_header
        line = string.gsub(line, '%{{first_index}}', tostring(first_index + 1))
        line = string.gsub(line, '%{{last_index}}', tostring(last_index))
        line = string.gsub(line, '%{{num_skills}}', tostring(#skills))
        line = string.gsub(line, '%{{page}}', tostring(page + 1))
        line = string.gsub(line, '%{{num_pages}}', tostring(num_pages))

        table.insert(res_lines, line)

        if #skills > 7 then
            table.insert(res_lines, TSWL_Professions[prof_name].config.txt_res_hint_large)
        end

        -- add tradeskill res_lines
        for i, s in ipairs(skills) do
            if i > first_index and i <= last_index then -- paging offset
                if s.num_craftable > 0 then
                    line = TSWL_Professions[prof_name].config.txt_res_skill_craftable
                    line = string.gsub(line, '%{{num_craftable}}', s.num_craftable)
                else
                    line = TSWL_Professions[prof_name].config.txt_res_skill
                end

                line = string.gsub(line, '%{{item_link}}', s.link)

                local reagents_str = ''

                -- add mats
                for j, v in ipairs(s.reagents) do
                    reagents_str = reagents_str .. (v.count .. 'x' .. v.name)

                    if j < #s.reagents then
                        reagents_str = reagents_str .. '/'
                    end
                end

                line = string.gsub(line, '%{{reagents}}', reagents_str)

                if s.cd then
                    local cd_mins = floor((s.cd / 60) + 0.5)

                    if cd_mins > 60 then
                        local cd_hrs = floor((cd_mins / 60) + 0.5)

                        line = string.gsub(line, '%{{cd}}', '(CD: ' .. cd_hrs .. ' hrs.)')
                    else
                        line = string.gsub(line, '%{{cd}}', '(CD: ' .. cd_mins .. ' mins.)')
                    end
                else
                    line = string.gsub(line, '%{{cd}}', '')
                end

                if string.len(line) > 255 then -- cut long res_lines
                    line = string.sub(line, 1, 252) .. '...' -- indicator
                end

                table.insert(res_lines, line)
            end
        end

        if #skills > last_index then
            line = TSWL_Professions[prof_name].config.txt_res_hint_paging

            line = string.gsub(line, '%{{query_cmd}}', query_cmd)
            line = string.gsub(line, '%{{next_page}}', tostring(page + 2))

            table.insert(res_lines, line)
        end
    else
        table.insert(res_lines, TSWL_Professions[prof_name].config.txt_res_empty)
    end

    if string.len(TSWL_Professions[prof_name].config.txt_res_footer) then
        table.insert(res_lines, TSWL_Professions[prof_name].config.txt_res_footer)
    end

    return res_lines
end

function TSWL.main.SendWhisperResponse(player, lines)
    for i, l in ipairs(lines) do
        ChatThrottleLib:SendChatMessage('NORMAL', 'TRADESKILL_WHISPER_LOOKUP_RESPONSE', l, 'WHISPER', 'Common', player)
    end
end

function TSWL.main.ProcessWhisperMessage(player, msg)
    if TSWL.helpers.IsCmdMessage(msg) then
        local cmd, query, page = TSWL.helpers.ParseWhisperMessage(msg)
        local prof_name = TSWL.helpers.GetProfessionNameByCmd(cmd)

        if TSWL_Professions[prof_name] then
            local skills = TSWL.main.GetTradeSkills(prof_name, query)
            local res_lines = TSWL.main.BuildWhisperResponse(prof_name, skills, page, (query and cmd .. ' ' .. query or cmd))

            TSWL.main.SendWhisperResponse(player, res_lines)
        end
    end
end

function TSWL.main.Init(name)
    if name == TSWL_AddonName then
        TSWL_Professions = TSWL_Professions or {}

        for k, v in pairs(TSWL_Professions) do
            -- update config
            TSWL.util.table_update(TSWL_Professions[k], TSWL.defaults.Profession)

            for i = 1, #TSWL_Professions[k].data.tradeskills do
                TSWL_Professions[k].data.tradeskills[i] = TSWL_Professions[k].data.tradeskills[i] or {}
                TSWL.util.table_update(TSWL_Professions[k].data.tradeskills[i], TSWL.defaults.ProfessionTradeSkill)

                for j = 1, #TSWL_Professions[k].data.tradeskills[i].reagents do
                    TSWL_Professions[k].data.tradeskills[i].reagents[j] = TSWL_Professions[k].data.tradeskills[i].reagents[j] or {}
                    TSWL.util.table_update(TSWL_Professions[k].data.tradeskills[i].reagents[j], TSWL.defaults.ProfessionTradeSkillReagent)
                end
            end
        end

        TSWL.options.SetupPanel()
    end
end

-- main event handler
function TSWL.main.EventHandler(self, event, ...)
    if event == 'ADDON_LOADED' then
        local name = ...

        TSWL.main.Init(name)
    elseif event == 'TRADE_SKILL_UPDATE' then
        if TSWL.main.state.add_profession then
            TSWL.main.AddProfession()
        else
            TSWL.main.UpdateProfessionData()
        end
    elseif event == 'CHAT_MSG_WHISPER' then
        local wsp_msg, wsp_name = ...

        TSWL.main.ProcessWhisperMessage(wsp_name, wsp_msg)
    end
    --[[elseif event == 'PLAYER_LOGIN' then
        for k, v in pairs(TSWL_Professions) do
            print('TSWL loaded: ' .. k .. ' (' .. v.config.cmd .. ', ' .. #v.data.tradeskills .. ' tradeskills)')
    end]]
end

-- create mainframe and register events
TSWL.main.frame = CreateFrame('Frame')
TSWL.main.frame:RegisterEvent('TRADE_SKILL_UPDATE')
TSWL.main.frame:RegisterEvent('CHAT_MSG_WHISPER')
TSWL.main.frame:RegisterEvent('PLAYER_ENTERING_WORLD')
TSWL.main.frame:RegisterEvent('ADDON_LOADED')
TSWL.main.frame:SetScript('OnEvent', TSWL.main.EventHandler)

-- register slashcommand
SLASH_TSWL_SLASHCOMMAND1 = '/tswl'
function SlashCmdList.TSWL_SLASHCOMMAND(msg, editBox)
    if string.len(msg) == 0 then
        -- Workaround: this function has to be called twice
        InterfaceOptionsFrame_OpenToCategory('TradeSkillWhisperLookup')
        InterfaceOptionsFrame_OpenToCategory('TradeSkillWhisperLookup')
    else
        if TSWL.helpers.IsCmdMessage(msg) then
            local cmd, query, page = TSWL.helpers.ParseWhisperMessage(msg)
            local prof_name = TSWL.helpers.GetProfessionNameByCmd(cmd)

            print(cmd, query, page)

            if TSWL_Professions[prof_name] then
                local skills = TSWL.main.GetTradeSkills(prof_name, query)
                local res_lines = TSWL.main.BuildWhisperResponse(prof_name, skills, page, (query and cmd .. ' ' .. query or cmd))

                for i, l in ipairs(res_lines) do
                    DEFAULT_CHAT_FRAME:AddMessage(l)
                end
            end
        end
    end
end
