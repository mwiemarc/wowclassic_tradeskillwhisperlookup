# wowclassic_tradeskillwhisperlookup
* Provides other players the ability to lookup your profession tradeskills by whisper command.
* Players will recieve all tradeskills by sending the whisper command without paramenters or search for items adding their name (or parts of name).
* Responses are limited to 20 messages per request/page (pages can be selected by adding a number to the end of the command)
* You can also exclude reagents from responses by adding thery names to "Ignore reagents" in options (e.g. Leaded Vial or just Vail to exclude all of them).
* Common misspells can be caught by adding a custom query in options (Usecase: A players whats to see all potions and sends "!alchemy pots" instead of "!alchemy pot" cause they are actually named "Potion of ..." then you could add a query which looks for "pot" instead of "pots". e.g. pots=pot or flasks=flask).
* All crafting professions should be supported.
* Currently translations for english and german are included but the addon should work for every locale.


(this is my first addon so far, hope you like it and i would appreciate feedback)




### Example whisper commands would be: 
- !smith - get all tradeskills (page 1)
- !smith 3 - get all tradeskill (page 3)
- !smith boot - get items with "boot" in name
- !smith boot 2 - get items with "boot" in name (page 2)
- !smith Dark Iron Plate - get specific item


## addon commands
* /tswl - open options panel
* /tswl <whisper command> - print whisper command response to chat (for testing)

  
## screenshots
![Examples](https://i.imgur.com/clyrzmQ.jpg "Examples")
![Config](https://i.imgur.com/tw5Db4J.jpg "Config")
