local TSWL_AddonName, TSWL = ...
local LOCALE = GetLocale()

if LOCALE == 'enUS' or LOCALE == 'enGB' or TSWL.L == nil then -- use english as fallback language
    local L = {}

    L['POPUP_ADD_PROFESSION_TXT'] = 'Please open the Tradeskill window of your desired Profession to continue'
    L['POPUP_CONFIG_UPDATED_TXT'] = '|cffff0000Due to a database update, it may be necessary to make some settings again.|f\n\n|cffffff00Afterwards please open the respective Tradeskill windows to read in the skills again.|r'

    L['MSG_ADD_PROFESSION_SUCCESS'] = 'Profession added successful'
    L['MSG_ADD_PROFESSION_ERR_EXISTS'] = 'Profession already added'

    L['CONFIG_DEFAULT_RESPONSE_NO_RESULTS'] = 'No results for your request'
    L['CONFIG_DEFAULT_RESPONSE_HEADER'] = 'Results {{first_index}}-{{last_index}} (of {{num_results}}) (Page {{page}}/{{num_pages}}) {rt3} = Reagents available'
    L['CONFIG_DEFAULT_RESPONSE_FOOTER'] = ''
    L['CONFIG_DEFAULT_RESPONSE_FEATURED_HEADER'] = "Hay! This is a selection of my {{num_skills}} Skills. If you got any question don't be afraid to ask ;)"
    L['CONFIG_DEFAULT_RESPONSE_FEATURED_FOOTER'] = "Not your's? Send {{cmd}} 1 to lookup all of my skills or {{cmd}} SEARCHTERM to search my skills"
    L['CONFIG_DEFAULT_RESPONSE_HINT_DELAY'] = 'It could take a moment to recieve all messages'
    L['CONFIG_DEFAULT_RESPONSE_HINT_PAGING'] = 'Next page: {{cmd_query}} {{next_page}}'
    L['CONFIG_DEFAULT_RESPONSE_SKILL'] = '{{item}} ({{reagents}}) {{cd}}'
    L['CONFIG_DEFAULT_RESPONSE_SKILL_CRAFTABLE'] = '{{item}} {{num_craftable}}x{rt3} ({{reagents}}) {{cd}}'

    L['LOCALE_COOLDOWN_TIMELEFT_TXT'] = 'Cd timeleft'

    L['LOCALE_SHORT_HOURS'] = 'hrs.'
    L['LOCALE_SHORT_MINUTES'] = 'mins.'

    L['OPTIONS_LABEL_COMMAND'] = 'Whisper command'
    L['OPTIONS_LABEL_SPELLFIX'] = 'Misspell correction'
    L['OPTIONS_LABEL_FEATURED'] = 'Featured skills'
    L['OPTIONS_LABEL_HIDE_REAGENTS'] = 'Hide reagents'
    L['OPTIONS_LABEL_RESPONSE_HEADER'] = 'Response: Header'
    L['OPTIONS_LABEL_RESPONSE_FOOTER'] = 'Response: Footer'
    L['OPTIONS_LABEL_RESPONSE_FEATURED_HEADER'] = 'Response: Featured skills header'
    L['OPTIONS_LABEL_RESPONSE_FEATURED_FOOTER'] = 'Response: Featured skills footer'
    L['OPTIONS_LABEL_RESPONSE_NO_RESULTS'] = 'Response: No results'
    L['OPTIONS_LABEL_RESPONSE_SKILL'] = 'Response: Tradeskill'
    L['OPTIONS_LABEL_RESPONSE_SKILL_CRAFTABLE'] = 'Response: Tradeskill (reagents owned)'
    L['OPTIONS_LABEL_RESPONSE_HINT_DELAY'] = 'Response hint: Response delay'
    L['OPTIONS_LABEL_RESPONSE_HINT_PAGING'] = 'Response hint: Paging'

    L['OPTIONS_TOOLTIP_AUTOCOMPLETE'] =
        'Available for |cff00ffffTradeskills|r/|cff00ffffItems|r and |cff00ffffValuekeys|r\n\nBy pressing |cff00ff00Tab|r or |cff00ff00Enter|r you can accept the suggestion\nHold |cff00ff00Ctrl|r to disable autocompletion temporary\n\n|cffffff00(This functions is in early development stage and can show some unexpected behaviors)|r'
    L['OPTIONS_TOOLTIP_SPELLFIX'] = 'Define words which will be replaced by another in request.\ne.g. |cff00ff00pots=pot|r or |cff00ff00flasks=flask|r or |cff00ff00flaks=flask|r\n\n|cffffff00(Split multiple entrys by semicolon)|r'
    L['OPTIONS_TOOLTIP_FEATURED'] = 'Define Tradeskills/Items which will be retured instead of the default tradeskill list when just the whisper command is recieved without parameters.\n\n|cffffff00(Split multiple entrys by semicolon)|r'
    L['OPTIONS_TOOLTIP_HIDE_REAGENTS'] = 'Define Reagents that should be hidden in response.\n\n|cffffff00(Split multiple entrys by semicolon)|r'
    L['OPTIONS_TOOLTIP_RESPONSE_HEADER'] =
        '|cff00ffffValuekeys|r\n\n|cff00ff00{{first_index}}|r = index of first entry on page\n|cff00ff00{{last_index}}|r = index of page last entry on page\n|cff00ff00{{num_results}}|r = number of results\n|cff00ff00{{num_tradeskills}}|r =profession total tradeskills\n|cff00ff00{{page}}|r = current page\n|cff00ff00{{num_pages}}|r = number of pages for request\n|cff00ff00{{request_cmd}}|r = recieved command\n|cff00ff00{{cmd}}|r = profession whisper command\n|cff00ff00{{skill_cur}}|r = your current profession skill level\n|cff00ff00{{skill_max}}|r = your max profession skill level\n|cff00ff00{{profession}}|r = profession'
    L['OPTIONS_TOOLTIP_RESPONSE_SKILL'] =
        '|cff00ffffValuekeys|r\n\n|cff00ff00{{index}}|r = index of entry on page\n|cff00ff00{{name}}|r = Tradeskill name\n|cff00ff00{{item}}|r = Item\n|cff00ff00{{reagents}}|r = required crafting reagents\n|cff00ff00{{num_craftable}}|r = number of craftable for owned reagents\n|cff00ff00{{cd}}|r = Cooldown timeleft'
    L['OPTIONS_TOOLTIP_RESPONSE_FOOTER'] = '|cffffff00(Leave empty to disable)|r'
    L['OPTIONS_TOOLTIP_RESPONSE_FEATURED_FOOTER'] = '|cffffff00(Leave empty to disable)|r'
    L['OPTIONS_TOOLTIP_RESPONSE_HINT_PAGING'] = '|cff00ffffValuekeys|r\n\n|cff00ff00{{page}}|r = current page\n|cff00ff00{{next_page}}|r = next page\n|cff00ff00{{num_pages}}|r = number of pages\n|cff00ff00{{request_cmd}}|r = recieved command'
    L['OPTIONS_TOOLTIP_RESPONSE_HINT_DELAY'] = 'If there are a large number of results, some messages will be delayed.\n\n|cffffff00(If too many messages are sent at once it can come to a disconnect otherwise)|r'

    TSWL.L = L
end
