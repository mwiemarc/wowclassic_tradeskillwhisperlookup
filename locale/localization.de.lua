local TSWL_AddonName, TSWL = ...
local LOCALE = GetLocale()

if LOCALE == 'deDE' then
    local L = {}

    L['POPUP_MSG_ADD_PROFESSION'] = 'Bitte öffnen Sie das gewünschte Berufsfenster um fortzufahren'
    L['POPUP_MSG_CONFIG_UPDATE_REQUIRED'] =
        'Aufgrund eines Updates ist es eventuell nötig einige Einstellungen erneut vorzunehmen.\nAußerdem sollten SIe für alle hinzugefügten Berufe das Berufsfenster einmal öffnen\n\nIch bitte dies zu entschuldigen und versuche so etwas in Zukunft zu vermeiden.'

    L['MSG_ADD_PROFESSION_SUCCESS'] = 'Beruf erfolgreich hinzugefügt: {{profession}}'
    L['MSG_ADD_PROFESSION_ERR_EXISTS'] = 'Beruf ist bereits vorhanden, schauen Sie in den Optionen unter TradeSkillWhisperLookup nach'

    L['CONFIG_DEFAULT_RESPONSE_HEADER'] = 'Ergebnisse {{first_index}}-{{last_index}} (von {{num_results}}) (Seite {{page}}/{{num_pages}}) {rt3} = Mats vorhanden'
    L['CONFIG_DEFAULT_RESPONSE_FOOTER'] = ''
    L['CONFIG_DEFAULT_RESPONSE_FEATURED_HEADER'] = 'Hallo! Dies ist eine kleine Auswahl meiner {{num_skills}} Fertigkeiten. Wenn du meine Dienste in anspruch nehmen möchtest zögere nicht zu fragen ;)'
    L['CONFIG_DEFAULT_RESPONSE_FEATURED_FOOTER'] = 'Nichts dabei? Mit "{{cmd}} 1" kannst du meine Fertigkeiten durchschauen oder mit "{{cmd}} SUCHBEGRIFF" direkt nach Items suchen'
    L['CONFIG_DEFAULT_RESPONSE_HINT_NO_RESULTS'] = 'Ihre Suche lieferte keine Ergebnisse'
    L['CONFIG_DEFAULT_RESPONSE_HINT_DELAYED'] = 'Es kann einen Moment dauern bis Sie alle Nachrichten erhalten haben'
    L['CONFIG_DEFAULT_RESPONSE_HINT_PAGING'] = 'Nächste Seite: {{request_cmd}} {{next_page}}'
    L['CONFIG_DEFAULT_RESPONSE_SKILL'] = '{{item_link}} ({{reagents}}) {{cd}}'
    L['CONFIG_DEFAULT_RESPONSE_SKILL_CRAFTABLE'] = '{{item_link}} {{num_craftable}}x{rt3} ({{reagents}}) {{cd}}'

    L['LOCALE_COOLDOWN_TIMELEFT_TXT'] = 'Cd. verbl.'

    L['LOCALE_SHORT_HOURS'] = 'Std.'
    L['LOCALE_SHORT_MINUTES'] = 'Min.'

    L['OPTIONS_LABEL_COMMAND'] = 'Flüster Befehl'
    L['OPTIONS_LABEL_SPELLFIX'] = 'Schreibfehler korrekturen (z.B.: tränke=trank;elixiere=elixier;...)'
    L['OPTIONS_LABEL_FEATURED'] = 'Vorgestellte Fertigkeiten (mehrere durch Semicolon trennen)'
    L['OPTIONS_LABEL_HIDE_REAGENTS'] = 'Versteckte Materialien (mehrere durch Semicolon trennen)'
    L['OPTIONS_LABEL_RESPONSE_HEADER'] = 'Antwort Kopfzeile'
    L['OPTIONS_LABEL_RESPONSE_FOOTER'] = 'Antwort Fußzeile (leer lassen zum ausschalten)'
    L['OPTIONS_LABEL_RESPONSE_FEATURED_HEADER'] = 'Vorgestellt Kopfzeile'
    L['OPTIONS_LABEL_RESPONSE_FEATURED_FOOTER'] = 'Vorgestellt Fußzeile (leer lassen zum ausschalten)'
    L['OPTIONS_LABEL_RESPONSE_HINT_NO_RESULTS'] = 'Anwort keine Treffer'
    L['OPTIONS_LABEL_RESPONSE_HINT_DELAYED'] = 'Antwort Hinweis große Anfrage'
    L['OPTIONS_LABEL_RESPONSE_HINT_PAGING'] = 'Antwort Hinweis Seiten'
    L['OPTIONS_LABEL_RESPONSE_SKILL'] = 'Antwort Fertigkeit'
    L['OPTIONS_LABEL_RESPONSE_SKILL_CRAFTABLE'] = 'Antwort Fertigkeit (Material vorhanden)'

    L['OPTIONS_HINT_FEATURED'] = 'Vorgestellte Ergebnisse: ....'

    L['OPTIONS_HINT_VALUEKEYS_HEADER'] =
        [[{{first_index}} = Index des ersten Ergebnisses auf der Seite
{{last_index}} = Index des letzten Ergebnisses auf der Seite
{{num_results}} = Anzahl der Ergebnisse
{{num_tradeskills}} = Anzahl der Fertigkeiten für den Beruf
{{page}} = Aktuelle Seite
{{num_pages}} = Anzahl der Seiten
{{request_cmd}} = Erhaltener Befehl
{{cmd}} = Beruf Flüsterbefehl
{{skill_cur}} = Dein aktuelles Berufslevel
{{skill_max}} = Dein max. Berufslevel
{{profession}} = Beruf]]

    L['OPTIONS_HINT_VALUEKEYS_PAGING'] = [[{{page}} = Aktuelle Seite
{{next_page}} = Nächste Seite
{{num_pages}} = Anzahl der Seiten
{{request_cmd}} = Erhaltener Befehl]]

    L['OPTIONS_HINT_VALUEKEYS_SKILL'] =
        [[{{index}} = Ergebniss index
{{name}} = Fertigkeitsname
{{item_link}} = Item link
{{reagents}} = Benötigtes Material
{{num_craftable}} = Herstellbar mit Material im Inv.
{{cd}} = Verbl. Abklingzeit (nur angezeigt wenn verbleibende Zeit)]]

    TSWL.L = L
end
