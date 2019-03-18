CLI Flow

> User inputs character name, server, & region (Sikz, Stormrage, US)

Shows character name, guild, race/class/spec, raider_io score, raid progression

Sikz <Consequence>
Pandaren Fury Warrior
411 ilvl 44.5 HoA lvl
M+ Score: 2,188
Raid Progression: 8/9 M

> Show recent runs

+19 WM 3/17/2019
+20* AD 3/17/2019
+19* FH 3/17/2019
+18* KR 3/17/2019
+14** WM 3/16/2019

> List dungeons

Atal'Dazar (AD)
Freehold (FH)
Tol Dagor (TD)
The Underrot (UNDR)
Temple of Sethraliss (TOS)
Waycrest Manor (WM)
Kings' Rest (KR)
Siege of Boralus (SIEGE)
The MOTHERLODE!! (ML)
Shrine of the Storm (SOTS)

> SIEGE

Your best Siege of Boralus is:
+18* 00:35:59
Tyrannical, Raging, Volcanic, Reaping
Score: 214.4
World Rank 1,062
Region Rank 309



Classes:
Scraper
  - Scrapes Raider.io for character information

Character
  - Takes in Name, Server, & Region
  - Generates raider.io URL and sends to Scraper, recieves character info back

Dungeon
  - Takes in info from Scraper and formats it

CLI
  - Faciliates the CLI workflow


