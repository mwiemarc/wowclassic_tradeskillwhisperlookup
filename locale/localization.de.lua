local TSWL_AddonName, TSWL = ...
local LOCALE = GetLocale()

if LOCALE == 'deDE' then
    local L = {}

    L['POPUP_ADD_PROFESSION_TXT'] = 'Bitte öffnen Sie das Fertigkeitenfenster des gewünschte Berufes um fortzufahren'
    L['POPUP_CONFIG_UPDATED_TXT'] =
        'Aufgrund eines Datenbankupdates ist es eventuell nötig das Sie einige Einstellungen erneut vornehmen müssen.\n\n|cffffff00Öffnen Sie bitte im Anschluss die jeweiligen Berufsfenster um die Fertigkeiten neu einzulesen.|r'

    L['MSG_ADD_PROFESSION_SUCCESS'] = 'Beruf erfolgreich hinzugefügt'
    L['MSG_ADD_PROFESSION_ERR_EXISTS'] = 'Beruf ist bereits hinzugefügt'

    L['CONFIG_DEFAULT_RESPONSE_NO_RESULTS'] = '{rt7} Ihre Suche lieferte keine Ergebnisse'
    L['CONFIG_DEFAULT_RESPONSE_HEADER'] = 'Ergebnisse {{first_index}}-{{last_index}} (von {{num_results}}) (Seite {{page}}/{{num_pages}}) {rt3} = Mats vorhanden'
    L['CONFIG_DEFAULT_RESPONSE_FOOTER'] = ''
    L['CONFIG_DEFAULT_RESPONSE_FEATURED_HEADER'] = 'Hallo! Dies ist eine kleine Auswahl meiner {{num_skills}} Fertigkeiten. Wenn du meine Dienste in anspruch nehmen möchtest zögere nicht zu fragen ;)'
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
    L['OPTIONS_LABEL_RESPONSE_FOOTER'] = 'Antwort: Fußzeile\n(leer lassen zum ausschalten)'
    L['OPTIONS_LABEL_RESPONSE_FEATURED_HEADER'] = 'Antwort: Vorgestellte Fertigkeiten Kopfzeile'
    L['OPTIONS_LABEL_RESPONSE_FEATURED_FOOTER'] = 'Antwort: Vorgestellte Fertigkeiten Fußzeile\n(leer lassen zum ausschalten)'
    L['OPTIONS_LABEL_RESPONSE_NO_RESULTS'] = 'Anwort: Keine Treffer'
    L['OPTIONS_LABEL_RESPONSE_SKILL'] = 'Antwort: Fertigkeit'
    L['OPTIONS_LABEL_RESPONSE_SKILL_CRAFTABLE'] = 'Antwort: Fertigkeit (Material vorhanden)'
    L['OPTIONS_LABEL_RESPONSE_HINT_DELAY'] = 'Antwort Hinweis: Antwortverzögerung'
    L['OPTIONS_LABEL_RESPONSE_HINT_PAGING'] = 'Antwort Hinweis: Seiten'

    L['OPTIONS_HINT_SPELLFIX'] = 'Legen Sie Wörter fest welche durch andere bei der Suche ersetzt werden sollen.\nz.B.: tränke=trank oder elixiere=elixier oder flasks=fläschchen\n(Trennen Sie mehrere Einträge durch ein Semikolon)'
    L['OPTIONS_HINT_FEATURED'] = 'Fertigkeiten/Items welche Angezeigt werden wenn der Flüsterbefehl ohne weitere Parameter Empfangen wurde.\n(Trennen Sie mehrere Einträge durch ein Semikolon)'
    L['OPTIONS_HINT_HIDE_REAGENTS'] = 'Materialen welche nicht mit aufgelistet werden sollen.\n(Trennen Sie mehrere Einträge durch ein Semikolon)'
    L['OPTIONS_HINT_HEADER'] =
        '{{first_index}} = Nr. des ersten Ergebnisses auf der Seite | {{last_index}} = Nr. des letzten Ergebnisses auf der Seite | {{num_results}} = Anzahl der Ergebnisse | {{num_tradeskills}} = Anzahl der Fertigkeiten für den Beruf | {{page}} = Aktuelle Seite | {{num_pages}} = Anzahl der Seiten | {{request_cmd}} = Erhaltener Befehl | {{cmd}} = Beruf Flüsterbefehl | {{skill_cur}} = Dein aktuelles Berufslevel | {{skill_max}} = Dein max. Berufslevel | {{profession}} = Beruf'
    L['OPTIONS_HINT_PAGING'] = '{{page}} = Aktuelle Seite | {{next_page}} = Nächste Seite | {{num_pages}} = Anzahl der Seiten | {{request_cmd}} = Erhaltener Befehl'
    L['OPTIONS_HINT_SKILL'] = '{{index}} = Ergebniss Nr. | {{name}} = Fertigkeitsname | {{item}} = Item | {{reagents}} = Benötigtes Material | {{num_craftable}} = Anzahl Herstellbar | {{cd}} = Verbl. Abklingzeit'

    L['OPTIONS_TOOLTIP_AUTOCOMPLETE'] =
        'Verfügbar für |cff00ffffFertigkeiten|r/|cff00ffffItems|r und |cff00ffffWerteschlüssel|r\n\nMit |cff00ff00Tab|r oder |cff00ff00Enter|r können Sie den Vorschlag akzeptieren\nDurch |cff00ff00Strg|r können Sie die Autovervollständigung kurzzeitig aussetzten\n\n|cffffff00(Diese Funktion befindet sich noch in Entwicklung und könnte unerwartetes Verhalten zeigen)|r'

    TSWL.L = L
end
