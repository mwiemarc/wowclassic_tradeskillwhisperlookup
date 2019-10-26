local TSWL_AddonName, TSWL = ...
local LOCALE = GetLocale()

if LOCALE == 'enUS' or LOCALE == 'enGB' or TSWL.L == nil then -- use english as fallback language
    local L = {}

    L['LOCALE_HOURS'] = 'hrs.'
    L['LOCALE_MINUTES'] = 'mins.'

    L['POPUP_MSG_ADD_PROFESSION'] = 'Please open the desired Profession window to continue'
    L['POPUP_MSG_CONFIG_UPDATE_REQUIRED'] = 'Aufgrund eines Updates ist es eventuell nötig einige Einstellungen erneut vorzunehmen.\nIch bitte dies zu entschuldigen und versuche so etwas in Zukunft zu vermeiden.'

    L['MSG_ADD_PROFESSION_SUCCESS'] = 'Profession {{profession}} added successful'
    L['MSG_ADD_PROFESSION_FAIL'] = 'Failed to add Profession (already added?)'

    L['CONFIG_DEFAULT_RESPONSE_HEADER'] = 'Results {{first_index}}-{{last_index}} (of {{num_results}}) (Page {{page}}/{{num_pages}}) {rt3} = Reagents available'
    L['CONFIG_DEFAULT_RESPONSE_FOOTER'] = ''
    L['CONFIG_DEFAULT_RESPONSE_FEATURED_HEADER'] = 'XxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXx'
    L['CONFIG_DEFAULT_RESPONSE_FEATURED_FOOTER'] = 'XxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXx'
    L['CONFIG_DEFAULT_RESPONSE_NO_RESULTS'] = 'No results for your request'
    L['CONFIG_DEFAULT_RESPONSE_HINT_DELAYED'] = 'It could take a moment to recieve all messages'
    L['CONFIG_DEFAULT_RESPONSE_HINT_PAGING'] = 'Next page: {{cmd_query}} {{next_page}}'
    L['CONFIG_DEFAULT_RESPONSE_SKILL'] = '{{item_link}} ({{reagents}}) {{cd}}'
    L['CONFIG_DEFAULT_RESPONSE_SKILL_CRAFTABLE'] = '{{item_link}} {{num_craftable}}x{rt3} ({{reagents}}) {{cd}}'

    L['OPTIONS_LABEL_COMMAND'] = 'Whisper command'
    L['OPTIONS_LABEL_SPELLFIX'] = 'Misspell correction (e.g. pots=pot;flasks=flask;...)'
    L['OPTIONS_LABEL_FEATURED'] = 'Featured skills (serperate multiple by semicolon)'
    L['OPTIONS_LABEL_IGNORE_REAGENTS'] = 'Ignore reagents (serperate multiple by semicolon)'
    L['OPTIONS_LABEL_RESPONSE_HEADER'] = 'Response header'
    L['OPTIONS_LABEL_RESPONSE_FOOTER'] = 'Response footer (leave empty to disable)'
    L['OPTIONS_LABEL_RESPONSE_FEATURED_HEADER'] = 'Featured header'
    L['OPTIONS_LABEL_RESPONSE_FEATURED_FOOTER'] = 'Featured footer (leave empty to disable)'
    L['OPTIONS_LABEL_RESPONSE_NO_RESULTS'] = 'Response no results'
    L['OPTIONS_LABEL_RESPONSE_HINT_DELAYED'] = 'Response hint large request'
    L['OPTIONS_LABEL_RESPONSE_HINT_PAGING'] = 'Response hint paging'
    L['OPTIONS_LABEL_RESPONSE_SKILL'] = 'Response tradeskill'
    L['OPTIONS_LABEL_RESPONSE_SKILL_CRAFTABLE'] = 'Response tradeskill (craftable)'

    L['OPTIONS_HINT_VALUEKEYS'] =
        [[{{first_index}} = index of page first entry
    {{last_index}} = index of page last entry
    {{num_results}} = number of results
    {{num_skills}} = profession total tradeskills
    {{page}} = current page
    {{next_page}} = next page
    {{num_pages}} = number of pages
    {{request_cmd}} = recieved command
    {{cmd}} = profession whisper command
    {{skill_cur}} = your current profession skill level
    {{skill_max}} = your max profession skill level
    {{profession}} = profession\n]]
    L['OPTIONS_HINT_VALUEKEYS_SKILL'] =
        [[{{index}} = Entry index
    {{name}} = Tradeskill name
    {{item_link}} = Tradeskill item link
    {{reagents}} = Required crafting reagents
    {{num_craftable}} = Number craftable for owned reagents
    {{cd}} = Cooldown timeleft (Only shown if skill has active cooldowns)\n]]
    L['OPTIONS_HINT_FEATURED'] = 'XxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXx'

    TSWL.L = L
end
