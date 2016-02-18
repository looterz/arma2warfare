# [Warfare V2.066 R4.1 RTM Bomba Edition](http://code.google.com/p/arma2warfare/downloads/detail?name=WarfareV2.066.R4.1.Bomba.Edition.zip) #
Build 486

**Highlights**

  * New: Team notification after commander sold factory
  * New: Aircrafts can flight out of boundaries, if boundaries are enabled
  * New: Support Lingor island
  * New: Mando Missiles

  * Fix AI units not respawned sometimes
  * Fix Artillery fired before animation completed (set direction)
  * Fix Marker tracking on map now depend from client FPS (for reduce lags on client machine)
  * Fix Disabled ability to build factories and defences in stones.
  * Fix Optimize server scripts, reduce lags
  * Fix: Sometimes discount prices are not displayed
  * Fix: Arty different types does not work (work only one arty type).For sample GRAD\_RU and GRAD\_TK\_EP1 - with different camufludge - work only GRAD-RU
  * Fix: Town patrol: AI units dont patrolled town, stayed at respawn place
  * Fix: Magazines setted to two slots in Buy Gear Menu
  * Fix: On Chernarus world, playable units replaced to takistan units, which can use backpacks.
  * Other bugs and improvements - see beta version wiki pages

Whats new:
  * BaseHunting restriction within a specified period in the settings (30min, 1h, 1.5h, 2h)
- The player has violated the basehunting restriction, die and lose their money.

  * Iincreased strength of buildings to 5 times
  * Changed the mechanism of charging money for the capture of the city
For the capture of the city charged the total cash = 500 `*` (last max SV) - the maximum value is reached under the occupation
This cash is divided into equal among all players who participated in the capture of the city (including AI)
It is distributed in the proportion of 75% of those who captured 25%, and those who helped (depending on distance from the central depot)
If the assistants not exists, then the sum of adding to the assault cash
If there are no invaders, the sum of adding players to assistants cash

The capture of the city with 10SV one player - the player will be awarded for the capture equal to 500 `*` 10 = $ 5000
The capture of the city with 10SV five players - each player will be awarded for the capture equal to 500 `*` 10 / 5 = $ 1000
The capture of the city with 10SV one player and two assistants -
Assault team get 500 `*` 10 `*` 0.75 = 3750 $
Every assistant team get - 500 `*` 10 `*` 0,25 / 2 = $ 625

  * Changed the mechanism of charging money for the time
- The team has less players will receive compensation for each missing player
if one team is 10 people, in another 8, each team member plays in the minorities, the will to receive compensation
for every less player;
currentIncome = currentIncome `*` (1 + (westPlayers - eastPlayers) / eastPlayers)

  * Correction supply and salaries income
if the server has lag, every salary (supply and money) increasing to lag coefficient,
ie if the salary comes once in 1.5 minutes instead of once per minute, the amount will be increased to 1.5

  * Selection of a suitable camouflage in accordance with the world, removed the duplicated vehicles (wood and sand camo)
map chernorusi mostly use vehicles and soldiers in wood camo
map takistana mostly use vehicles and soldiers in sand camo