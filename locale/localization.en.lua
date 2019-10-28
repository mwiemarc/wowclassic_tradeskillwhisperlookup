local TSWL_AddonName, TSWL = ...
local LOCALE = GetLocale()

if LOCALE == 'enUS' or LOCALE == 'enGB' or TSWL.L == nil then -- use english as fallback language
    local L = {}

    L['POPUP_ADD_PROFESSION_TXT'] = 'Please open the Tradeskill window of your desired Profession to continue'
    L['POPUP_CONFIG_UPDATED_TXT'] = 'Due to a database update, it may be necessary to make some settings again.\n\n|cffffff00Afterwards please open the respective Tradeskill windows to read in the skills again.|r'

    L['MSG_ADD_PROFESSION_SUCCESS'] = 'Profession added successful'
    L['MSG_ADD_PROFESSION_ERR_EXISTS'] = 'Profession already added'

    L['CONFIG_DEFAULT_RESPONSE_NO_RESULTS'] = '{rt7} No results for your request'
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
    L['OPTIONS_LABEL_RESPONSE_FOOTER'] = 'Response: Footer\n(leave empty to disable)'
    L['OPTIONS_LABEL_RESPONSE_FEATURED_HEADER'] = 'Response: Featured skills header'
    L['OPTIONS_LABEL_RESPONSE_FEATURED_FOOTER'] = 'Response: Featured skills footer\n(leave empty to disable)'
    L['OPTIONS_LABEL_RESPONSE_NO_RESULTS'] = 'Response: No results'
    L['OPTIONS_LABEL_RESPONSE_SKILL'] = 'Response: Tradeskill'
    L['OPTIONS_LABEL_RESPONSE_SKILL_CRAFTABLE'] = 'Response: Tradeskill (reagents owned)'
    L['OPTIONS_LABEL_RESPONSE_HINT_DELAY'] = 'Response hint: Response delay'
    L['OPTIONS_LABEL_RESPONSE_HINT_PAGING'] = 'Response hint: Paging'

    L['OPTIONS_HINT_SPELLFIX'] = 'Define words which will be replaced by another in request.\ne.g. pots=pot or flasks=flask or flaks=flask\n(Split multiple entrys by semicolon)'
    L['OPTIONS_HINT_FEATURED'] = 'Tradeskills/Items which will be retured instead of the default tradeskill list when just the whisper command is recieved without parameters.\n(Split multiple entrys by semicolon)'
    L['OPTIONS_HINT_HIDE_REAGENTS'] = 'Reagents should will be hidden in response.\n(Split multiple entrys by semicolon)'
    L['OPTIONS_HINT_HEADER'] =
        '{{first_index}} = index of first entry on page | {{last_index}} = index of page last entry on page | {{num_results}} = number of results | {{num_tradeskills}} =profession total tradeskills | {{page}} = current page | {{num_pages}} = number of pages for request | {{request_cmd}} = recieved command | {{cmd}} = profession whisper command | {{skill_cur}} = your current profession skill level | {{skill_max}} = your max profession skill level | {{profession}} = profession'
    L['OPTIONS_HINT_PAGING'] = '{{page}} = Aktuelle Seite | {{next_page}} = Nächste Seite | {{num_pages}} = Anzahl der Seiten | {{request_cmd}} = Erhaltener Befehl'
    L['OPTIONS_HINT_SKILL'] = '{{index}} = index of entry on page | {{name}} = Tradeskill name | {{item}} = Item | {{reagents}} = required crafting reagents | {{num_craftable}} = number of craftable for owned reagents | {{cd}} = Cooldown timeleft'

    L['OPTIONS_TOOLTIP_AUTOCOMPLETE'] =
        'Available for |cff00ffffTradeskills|r/|cff00ffffItems|r and |cff00ffffValuekeys|r\n\nBy pressing |cff00ff00Tab|r or |cff00ff00Enter|r you can accept the suggestion\nHold |cff00ff00Ctrl|r to disable autocompletion temporary\n\n|cffffff00(This functions is in early development stage and can show some unexpected behaviors)|r'

    TSWL.L = L
end
