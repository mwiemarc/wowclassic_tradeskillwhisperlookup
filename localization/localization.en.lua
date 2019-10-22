local TSWL_AddonName, TSWL = ...
local LOCALE = GetLocale()

if LOCALE == 'enUS' or LOCALE == 'enGB' or TSWL.L == nil then -- use english as fallback language
    local L = {}

    L['LOCALE_TXT_HOURS'] = 'hrs.'
    L['LOCALE_TXT_MINUTES'] = 'mins.'

    L['MSG_PROFESSION_ADD_POPUP'] = 'Please open the desired Profession window to continue'
    L['MSG_PROFESSION_ADDED'] = 'Profession {{profession}} added successful'
    L['MSG_PROFESSION_ADDED_FAIL'] = 'Failed to add Profession'

    L['DEFAULT_RESPONSE_HEADER'] = 'Results {{first_index}}-{{last_index}} (of {{num_skills}}) (Page {{page}}/{{num_pages}}) {rt3} = Reagents available'
    L['DEFAULT_RESPONSE_EMPTY'] = 'No results for your request'
    L['DEFAULT_RESPONSE_FOOTER'] = 'Thanks for your request, if you got any questions feel free to ask =)'
    L['DEFAULT_RESPONSE_HINT_LARGE'] = 'It could take a moment to recieve all messages'
    L['DEFAULT_RESPONSE_HINT_PAGING'] = 'Next page: {{query_cmd}} {{next_page}}'
    L['DEFAULT_RESPONSE_SKILL'] = '{{item_link}} ({{reagents}}) {{cd}}'
    L['DEFAULT_RESPONSE_SKILL_CRAFTABLE'] = '{{item_link}} {{num_craftable}}x{rt3} ({{reagents}}) {{cd}}'

    L['TXT_CONFIG_COMMAND'] = 'Whisper command'
    L['TXT_CONFIG_SPELLFIX'] = 'Misspell fix (pots=pot;flasks=flask;...)'
    L['TXT_CONFIG_IGNORE_REAGENTS'] = 'Ignore reagents (serperate by semicolon)'
    L['TXT_CONFIG_RESPONSE_HEADER'] = 'Response header row'
    L['TXT_CONFIG_RESPONSE_EMPTY'] = 'Response no matches'
    L['TXT_CONFIG_RESPONSE_FOOTER'] = 'Response footer row (leave empty to disable)'
    L['TXT_CONFIG_RESPONSE_HINT_LARGE'] = 'Response hint large request'
    L['TXT_CONFIG_RESPONSE_HINT_PAGING'] = 'Response hint paging'
    L['TXT_CONFIG_RESPONSE_SKILL'] = 'Response tradeskill'
    L['TXT_CONFIG_RESPONSE_SKILL_CRAFTABLE'] = 'Response tradeskill (craftable)'

    TSWL.L = L
end
