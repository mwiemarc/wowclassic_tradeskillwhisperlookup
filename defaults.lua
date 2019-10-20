local TSWL_AddonName, TSWL = ...

TSWL.defaults = {}

TSWL.defaults.Profession = {
    config = {
        cmd = nil,
        txt_spellfix = '',
        txt_ignore_reagents = '',
        txt_res_header = TSWL.L['DEFAULT_RESPONSE_HEADER'],
        txt_res_empty = TSWL.L['DEFAULT_RESPONSE_EMPTY'],
        txt_res_footer = TSWL.L['DEFAULT_RESPONSE_FOOTER'],
        txt_res_hint_large = TSWL.L['DEFAULT_RESPONSE_HINT_LARGE'],
        txt_res_hint_paging = TSWL.L['DEFAULT_RESPONSE_HINT_PAGING'],
        txt_res_skill = TSWL.L['DEFAULT_RESPONSE_SKILL'],
        txt_res_skill_craftable = TSWL.L['DEFAULT_RESPONSE_SKILL_CRAFTABLE']
    },
    data = {
        skill_cur = nil,
        skill_max = nil,
        tradeskills = {}
    }
}

TSWL.defaults.ProfessionTradeSkill = {
    name = nil,
    link = nil,
    num_craftable = nil,
    cd = nil,
    reagents = {}
}

TSWL.defaults.ProfessionTradeSkillReagent = {
    name = nil,
    count = nil
}
