local TSWL_AddonName, TSWL = ...

TSWL.profession = {}

function TSWL.profession.GetProfessionByCmd(cmd)
    cmd = TSWL.util.stringTrim(string.lower(cmd))

    for k, v in pairs(TSWL_CharacterConfig.professions) do
        if TSWL.util.stringTrim(string.lower(v.config.cmd)) == cmd then
            return TSWL_CharacterConfig.professions[k]
        end
    end

    return nil
end

function TSWL.profession.TryAddProfession(isCrafting)
    if isCrafting then
        GetTradeSkillLine = GetCraftDisplaySkillLine
    end

    local profName = GetTradeSkillLine()

    if profName and not TSWL_CharacterConfig.professions[profName] then
        TSWL_CharacterConfig.professions[profName] = TSWL.util.tableDeepCopy(TSWL.defaultConfig.Profession)
        TSWL_CharacterConfig.professions[profName].config.cmd = '!' .. string.lower(profName)
        TSWL_CharacterConfig.professions[profName].data.name = profName

        TSWL.profession.TryUpdateProfessionData(isCrafting) -- update data

        TSWL.options.AddProfessionCallback(profName)
    else
        TSWL.options.AddProfessionCallback(nil)
    end

    TSWL.state.addProfession = false -- is not longer in add mode
end

function TSWL.profession.TryUpdateProfessionData(isCrafting)
    local GetTradeSkillLine = GetTradeSkillLine
    local GetNumTradeSkills = GetNumTradeSkills
    local GetTradeSkillInfo = GetTradeSkillInfo
    local GetTradeSkillCooldown = GetTradeSkillCooldown
    local GetTradeSkillItemLink = GetTradeSkillItemLink
    local GetTradeSkillNumReagents = GetTradeSkillNumReagents
    local GetTradeSkillReagentInfo = GetTradeSkillReagentInfo

    if isCrafting then -- change functions for enchanting
        GetTradeSkillLine = GetCraftDisplaySkillLine
        GetNumTradeSkills = GetNumCrafts
        GetTradeSkillItemLink = GetCraftItemLink
        GetTradeSkillNumReagents = GetCraftNumReagents
        GetTradeSkillReagentInfo = GetCraftReagentInfo

        GetTradeSkillInfo = function(i)
            local name, _, kind, num = GetCraftInfo(i)

            return name, kind, num
        end

        GetTradeSkillCooldown = function()
            return nil
        end
    end

    local profName, skillCur, skillMax = GetTradeSkillLine()

    if profName and TSWL_CharacterConfig.professions[profName] then
        TSWL_CharacterConfig.professions[profName].data.skillCur = skillCur
        TSWL_CharacterConfig.professions[profName].data.skillMax = skillMax
        TSWL_CharacterConfig.professions[profName].data.tradeskills = {} -- reinit saved skills

        for i = 1, GetNumTradeSkills() do
            local sname, kind, num = GetTradeSkillInfo(i)
            local lname = string.lower(sname)
            local skill = {
                name = sname,
                numCraftable = num,
                reagents = {},
                hiddenReagents = {}
            }

            if kind and kind ~= 'header' and kind ~= 'subheader' then -- is item
                -- get reagents
                for j = 1, GetTradeSkillNumReagents(i) do
                    local reagentName, _, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(i, j)

                    -- save reagent
                    if reagentName then
                        table.insert(
                            skill.reagents,
                            {
                                name = reagentName,
                                count = reagentCount
                            }
                        )
                    end
                end

                skill.cd = GetTradeSkillCooldown(i) -- get cooldown timestamp if cooldown left
                skill.link = GetTradeSkillItemLink(i) -- get itemlink

                if skill.cd then
                    skill.cd = skill.cd + time()
                end

                if not skill.link then
                    skill.link = '[' .. name .. ']' -- fallback: save tradeskill name overwise
                end

                table.insert(TSWL_CharacterConfig.professions[profName].data.tradeskills, skill) -- save skill
            end
        end
    end
end

function TSWL.profession.GetTradeSkills(prof, query, page)
    -- select all
    if not query then
        if page or string.len(prof.config.featured) == 0 then -- page is set or no featured
            return prof.data.tradeskills
        else
            local featured = TSWL.util.stringSplit(prof.config.featured, ';')
            local skills = {}

            for i, v in ipairs(featured) do -- get featured in correct order
                for ii, vv in ipairs(prof.data.tradeskills) do
                    if #skills < 16 and #skills < #featured then -- max one page of featured
                        local lname = string.lower(TSWL.util.linkToName(vv.link))

                        if string.match(string.lower(vv.name), string.lower(v)) or string.lower(vv.name) == string.lower(v) or string.match(lname, string.lower(v)) or lname == string.lower(v) then -- lookup tradeskill or item
                            table.insert(skills, vv)
                        end
                    end
                end
            end

            return skills
        end
    end

    query = string.lower(query) -- ignore case

    local skills = {}
    local spellfix = TSWL.util.stringSplit(prof.config.spellfix, ';') -- fix misspells/redirect query

    for i, v in ipairs(spellfix) do
        local sfSplit = TSWL.util.stringSplit(v, '=') -- spellfix is formated "misspell=spellfix"

        if string.match(string.lower(sfSplit[1]), query) then -- match misspell
            query = string.lower(sfSplit[2]) -- replace query
        end
    end

    for i, s in ipairs(prof.data.tradeskills) do
        local lname = string.lower(TSWL.util.linkToName(s.link))

        if string.match(string.lower(s.name), query) or string.lower(s.name) == query or string.match(lname, query) or lname == query then -- matching tradeskill or item
            table.insert(skills, s)
        end
    end

    return skills
end

function TSWL.profession.GetVisibleReagents(reagents, hiddenReagents)
    local arr = {}

    for i, v in ipairs(reagents) do
        if not TSWL.util.stringMatchArray(v.name, hiddenReagents) then
            table.insert(arr, v)
        end
    end

    return arr
end
