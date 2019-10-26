local TSWL_AddonName, TSWL = ...

TSWL.defaultConfig = {}

TSWL.defaultConfig.CharacterConfig = {
    configVersion = 1,
    professions = {}
}

TSWL.defaultConfig.Profession = {
    config = {
        cmd = '',
        spellfix = '',
        hideReagents = '',
        featured = '',
        responseHeader = TSWL.L['CONFIG_DEFAULT_RESPONSE_HEADER'],
        responseFooter = TSWL.L['CONFIG_DEFAULT_RESPONSE_FOOTER'],
        responseFeaturedHeader = TSWL.L['CONFIG_DEFAULT_RESPONSE_FEATURED_HEADER'],
        responseFeaturedFooter = TSWL.L['CONFIG_DEFAULT_RESPONSE_FEATURED_FOOTER'],
        responseHintNoResults = TSWL.L['CONFIG_DEFAULT_RESPONSE_HINT_NO_RESULTS'],
        responseHintDelayed = TSWL.L['CONFIG_DEFAULT_RESPONSE_HINT_DELAYED'],
        responseHintPaging = TSWL.L['CONFIG_DEFAULT_RESPONSE_HINT_PAGING'],
        responseSkill = TSWL.L['CONFIG_DEFAULT_RESPONSE_SKILL'],
        responseSkillCraftable = TSWL.L['CONFIG_DEFAULT_RESPONSE_SKILL_CRAFTABLE']
    },
    data = {
        name = '',
        skillCur = 0,
        skillMax = 0,
        tradeskills = {}
    }
}

TSWL.defaultConfig.ProfessionTradeSkill = {
    name = '',
    link = '',
    numCraftable = 0,
    cd = 0,
    reagents = {},
    hiddenReagents = {}
}

TSWL.defaultConfig.ProfessionTradeSkillReagent = {
    name = '',
    count = 0
}
