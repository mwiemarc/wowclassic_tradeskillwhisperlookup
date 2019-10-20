local TSWL_AddonName, TSWL = ...
local LOCALE = GetLocale()

if LOCALE == 'deDE' then
    local L = {}

    L['PROFESSION_NAME_ALCHEMY'] = 'Alchimie'
    L['PROFESSION_NAME_BLACKSMITHING'] = 'Schmiedekunst'
    L['PROFESSION_NAME_ENCHANTING'] = 'Verzauberkunst'
    L['PROFESSION_NAME_ENGINEERING'] = 'Ingenieurskunst'
    L['PROFESSION_NAME_LEATHERWORKING'] = 'Lederverarbeitung'
    L['PROFESSION_NAME_TAILORING'] = 'Schneiderei'
    L['PROFESSION_NAME_COOKING'] = 'Kochkunst'
    L['PROFESSION_NAME_FIRSTAID'] = 'Erste Hilfe'

    L['DEFAULT_RESPONSE_HEADER'] = 'Ergebnisse {{first_index}}-{{last_index}} (von {{num_skills}}) (Seite {{page}}/{{num_pages}}) {rt3} = Mats vorhanden'
    L['DEFAULT_RESPONSE_EMPTY'] = 'Ihre Suche lieferte keine Ergebnisse'
    L['DEFAULT_RESPONSE_FOOTER'] = 'Danke für Ihre Anfrage und falls Sie ein Anliegen haben zögern Sie bitte nicht zu mich anzusprechen =)'
    L['DEFAULT_RESPONSE_HINT_LARGE'] = 'Es kann einen Moment dauern bis Sie alle Nachrichten erhalten haben'
    L['DEFAULT_RESPONSE_HINT_PAGING'] = 'Nächste Seite: {{query_cmd}} {{next_page}}'
    L['DEFAULT_RESPONSE_SKILL'] = '{{item_link}} ({{reagents}}) {{cd}}'
    L['DEFAULT_RESPONSE_SKILL_CRAFTABLE'] = '{{item_link}} {{num_craftable}}x{rt3} ({{reagents}}) {{cd}}'

    L['MSG_PROFESSION_ADD_POPUP'] = 'Bitte öffnen Sie das gewünschte Berufsfenster um fortzufahren'
    L['MSG_PROFESSION_ADDED'] = 'Beruf {{profession}} erfolgreich hinzugefügt'
    L['MSG_PROFESSION_ADDED_FAIL'] = 'Beruf konnte nicht hinzugefügt werden'

    L['TXT_CONFIG_COMMAND'] = 'Flüster Befehl'
    L['TXT_CONFIG_SPELLFIX'] = 'Schreibfehler korrekturen (tränke=trank;elixiere=elixier;...)'
    L['TXT_CONFIG_IGNORE_REAGENTS'] = 'Ignoriere Materialien (durch Semicolon trennen)'
    L['TXT_CONFIG_RESPONSE_HEADER'] = 'Antwort Kopfzeile'
    L['TXT_CONFIG_RESPONSE_EMPTY'] = 'Anwort keine Treffer'
    L['TXT_CONFIG_RESPONSE_FOOTER'] = 'Antwort Fußzeile (leer lassen zum ausschalten)'
    L['TXT_CONFIG_RESPONSE_HINT_LARGE'] = 'Antwort Hinweis große Anfrage'
    L['TXT_CONFIG_RESPONSE_HINT_PAGING'] = 'Antwort Hinweis Seiten'
    L['TXT_CONFIG_RESPONSE_SKILL'] = 'Antwort Fertigkeit'
    L['TXT_CONFIG_RESPONSE_SKILL_CRAFTABLE'] = 'Antwort Fertigkeit (Material vorhanden)'

    TSWL.L = L
end
