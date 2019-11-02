local TSWL_AddonName, TSWL = ...
local LOCALE = GetLocale()

if LOCALE == 'deDE' then
    local L = {}

    L['POPUP_ADD_PROFESSION_TXT'] = 'Bitte öffnen Sie das Fertigkeitenfenster des gewünschte Berufes um fortzufahren'
    L['POPUP_CONFIG_UPDATED_TXT'] =
        '|cffff0000Aufgrund eines Datenbankupdates ist es eventuell nötig das Sie einige Einstellungen erneut vornehmen müssen.|r\n\n|cffffff00Öffnen Sie bitte im Anschluss die jeweiligen Berufsfenster um die Fertigkeiten neu einzulesen.|r'

    L['MSG_ADD_PROFESSION_SUCCESS'] = 'Beruf erfolgreich hinzugefügt'
    L['MSG_ADD_PROFESSION_ERR_EXISTS'] = 'Beruf ist bereits hinzugefügt'

    L['CONFIG_DEFAULT_RESPONSE_NO_RESULTS'] = 'Ihre Suche lieferte keine Ergebnisse'
    L['CONFIG_DEFAULT_RESPONSE_HEADER'] = 'Ergebnisse {{first_index}}-{{last_index}} (von {{num_results}}) (Seite {{page}}/{{num_pages}}) {rt3} = Mats vorhanden'
    L['CONFIG_DEFAULT_RESPONSE_FOOTER'] = ''
    L['CONFIG_DEFAULT_RESPONSE_FEATURED_HEADER'] = 'Hallo! Dies ist eine kleine Auswahl meiner {{num_skills}} Fertigkeiten. Für Fragen stehe ich gerne zur verfügung.'
    L['CONFIG_DEFAULT_RESPONSE_FEATURED_FOOTER'] = 'Nichts dabei? Mit {{cmd}} 1 können Sie meine Fertigkeiten durchschauen oder mit {{cmd}} SUCHBEGRIFF direkt nach Items suchen'
    L['CONFIG_DEFAULT_RESPONSE_HINT_DELAY'] = 'Es kann einen Moment dauern bis Sie alle Nachrichten erhalten haben'
    L['CONFIG_DEFAULT_RESPONSE_HINT_PAGING'] = 'Nächste Seite: {{request_cmd}} {{next_page}}'
    L['CONFIG_DEFAULT_RESPONSE_SKILL'] = '{{item}} ({{reagents}}) {{cd}}'
    L['CONFIG_DEFAULT_RESPONSE_SKILL_CRAFTABLE'] = '{{item}} {{num_craftable}}x{rt3} ({{reagents}}) {{cd}}'

    L['LOCALE_COOLDOWN_TIMELEFT_TXT'] = 'Cd. verbl.'

    L['LOCALE_SHORT_HOURS'] = 'Std.'
    L['LOCALE_SHORT_MINUTES'] = 'Min.'

    L['OPTIONS_LABEL_COMMAND'] = 'Flüsterbefehl'
    L['OPTIONS_LABEL_SPELLFIX'] = 'Schreibfehler korrekturen'
    L['OPTIONS_LABEL_FEATURED'] = 'Vorgestellte Fertigkeiten'
    L['OPTIONS_LABEL_HIDE_REAGENTS'] = 'Versteckte Materialien'
    L['OPTIONS_LABEL_RESPONSE_HEADER'] = 'Antwort: Kopfzeile'
    L['OPTIONS_LABEL_RESPONSE_FOOTER'] = 'Antwort: Fußzeile'
    L['OPTIONS_LABEL_RESPONSE_FEATURED_HEADER'] = 'Antwort: Vorgestellte Fertigkeiten Kopfzeile'
    L['OPTIONS_LABEL_RESPONSE_FEATURED_FOOTER'] = 'Antwort: Vorgestellte Fertigkeiten Fußzeile'
    L['OPTIONS_LABEL_RESPONSE_NO_RESULTS'] = 'Anwort: Keine Treffer'
    L['OPTIONS_LABEL_RESPONSE_SKILL'] = 'Antwort: Fertigkeit'
    L['OPTIONS_LABEL_RESPONSE_SKILL_CRAFTABLE'] = 'Antwort: Fertigkeit (Material vorhanden)'
    L['OPTIONS_LABEL_RESPONSE_HINT_PAGING'] = 'Antwort Hinweis: Seiten'
    L['OPTIONS_LABEL_RESPONSE_HINT_DELAY'] = 'Antwort Hinweis: Antwortverzögerung'

    L['OPTIONS_TOOLTIP_AUTOCOMPLETE'] =
        'Verfügbar für |cff00ffffFertigkeiten|r/|cff00ffffItems|r und |cff00ffffWerteschlüssel|r\n\nMit |cff00ff00Tab|r oder |cff00ff00Shift+Tab|r können Sie durch zum nächsten oder letzten Vorschlag wechseln\nMit |cff00ff00Enter|r oder |cff00ff00Strg+Tab|r können Sie den Vorschlag akzeptieren\nDurch |cff00ff00Alt|r können Sie die Autovervollständigung kurzzeitig aussetzten\n\n|cffffff00(Diese Funktion befindet sich noch in Entwicklung und könnte unerwartetes Verhalten zeigen)|r'
    L['OPTIONS_TOOLTIP_SPELLFIX'] =
        'Legen Sie Wörter fest welche durch andere bei der Suche ersetzt werden sollen.\nz.B.: |cff00ff00tränke=trank|r oder |cff00ff00elixiere=elixier|r oder |cff00ff00flasks=fläschchen|r\n\n|cffffff00(Trennen Sie mehrere Einträge durch ein Semikolon)|r'
    L['OPTIONS_TOOLTIP_FEATURED'] = 'Fertigkeiten/Items welche Angezeigt werden wenn der Flüsterbefehl ohne weitere Parameter Empfangen wurde.\n\n|cffffff00(Trennen Sie mehrere Einträge durch ein Semikolon)|r'
    L['OPTIONS_TOOLTIP_HIDE_REAGENTS'] = 'Materialen welche nicht mit aufgelistet werden sollen.\n\n|cffffff00(Trennen Sie mehrere Einträge durch ein Semikolon)|r'
    L['OPTIONS_TOOLTIP_RESPONSE_HEADER'] =
        '|cff00ffffWerteschlüssel|r\n\n|cff00ff00{{first_index}}|r = Nr. des ersten Ergebnisses auf der Seite\n|cff00ff00{{last_index}}|r = Nr. des letzten Ergebnisses auf der Seite\n|cff00ff00{{num_results}}|r = Anzahl der Ergebnisse\n|cff00ff00{{num_tradeskills}}|r = Anzahl der Fertigkeiten für den Beruf\n|cff00ff00{{page}}|r = Aktuelle Seite\n|cff00ff00{{num_pages}}|r = Anzahl der Seiten\n|cff00ff00{{request_cmd}}|r = Erhaltener Befehl\n|cff00ff00{{cmd}}|r = Beruf Flüsterbefehl\n|cff00ff00{{skill_cur}}|r = Dein aktuelles Berufslevel\n|cff00ff00{{skill_max}}|r = Dein max. Berufslevel\n|cff00ff00{{profession}}|r = Beruf'
    L['OPTIONS_TOOLTIP_RESPONSE_SKILL'] =
        '|cff00ffffWerteschlüssel|r\n\n|cff00ff00{{index}}|r = Ergebniss Nr.\n|cff00ff00{{name}}|r = Fertigkeitsname\n|cff00ff00{{item}}|r = Item\n|cff00ff00{{reagents}}|r = Benötigtes Material\n|cff00ff00{{num_craftable}}|r = Anzahl Herstellbar\n|cff00ff00{{cd}}|r = Verbl. Abklingzeit'
    L['OPTIONS_TOOLTIP_RESPONSE_FOOTER'] = '|cffffff00(Leer lassen zum ausschalten)|r'
    L['OPTIONS_TOOLTIP_RESPONSE_FEATURED_FOOTER'] = '|cffffff00(Leer lassen zum ausschalten)|r'
    L['OPTIONS_TOOLTIP_RESPONSE_HINT_PAGING'] =
        '|cff00ffffWerteschlüssel|r\n\n|cff00ff00{{page}}|r = Aktuelle Seite\n|cff00ff00{{next_page}}|r = Nächste Seite\n|cff00ff00{{num_pages}}|r = Anzahl der Seiten\n|cff00ff00{{request_cmd}}|r = Erhaltener Befehl'
    L['OPTIONS_TOOLTIP_RESPONSE_HINT_DELAY'] = 'Bei einer großen Anzahl von Ergebnissen kommen einige Nachrichten verzögert an.\n\n|cffffff00(Bei zu vielen Nachrichten auf einmal kann es sonst zu einem Disconnect kommen)|r'

    TSWL.L = L
end
