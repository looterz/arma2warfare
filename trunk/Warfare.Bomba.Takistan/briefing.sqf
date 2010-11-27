//--- Author [Bomba]


player createDiaryRecord["Diary", ["Warfare Upgrades", "<br/>To be able to purchase higher levels of equipment or units, the factories need to be upgraded by the commander. The commander will need both cash and supply points to do this. He may ask for contributions from other team players to help out. Each factory has 3 levels."]];
player createDiaryRecord["Diary", ["Warfare Supplies", "<br/>Each captured town has an Actual and Potential Value. On the map you will see this represented as 2 numbers seperated by a / for example; Zelenogorsk, once captured will start as 30/120. This means that the current supplies to each player from this town is $30 per minute. Each time a supply truck arrives at the town depot its value will increase by 10. Remember though, the supply truck must be either fully loaded from the HQ or a Supply point or, have come from a town with a higher actual value. you will also receive 4 x the actual value as cash if you or one of your squad drives the truck. Supply runs should be the responsibility of all. The best way to win Warfare is to work together capping and then supping up the town before moving to another."]];
player createDiaryRecord["Diary", ["Warfare Building", "<br/>The commander builds a base. Each side starts with one Mobile Headqarters (MHQ). This is a vehicle the commander can use to build th headquarters (HQ) anywhere on the map. After the HQ is built, other buildings can be constructed. Only the commander can build factories and defenses around the base using the HQ. The HQ can also be packed up back as MHQ again and moved to another location."]];

player createDiaryRecord["Diary", ["Warfare Team", "<br/>All players and AI soldiers can buy subordinates, equipment and vehicles from the main base as well as some vehicles from the captured town forts. You can access all available facilities through the Purchase interface from inside the main base perimeter or anywhere on the map once a Command Center has been erected. Accessible supply factories are indicated by icons on right edge of the screen. If a Barracks has been built, select the Purchase Gear button to purchase weapons and ammunition. The equipment you purchase here will also be your starting kit when you respawn. In Purchase Units button, you will find a list of unit type icons along the top. Here you can buy empty or manned units from soldiers to aircraft."]];

player createDiaryRecord["Diary", ["Warfare Commander", "<br/>The Commander can be controlled either by player or by AI. He has access to extra resources and abilities: developing the base, setting objectives for teams, and defining the strategy of your side."]];

player createDiaryRecord["Diary", ["Warfare Voting", "<br/>After starting the warfare mission, you are confronted with the Vote Commander screen. Click on any name in the player list to cast your vote. If you join a game that has already started, you will not see the Vote Commander screen. A new vote for a new Commander can be started anytime using the Vote option in the Options interface. The commander assigns a mission and a role to a team leader, whether it be AI or human player. The role can include the type of equipment and vehicles the AI teams will use. Players have control of what they will use in their team. Mission is the task for the team to perform. You may disable the Commander Vote Pop-up in the Team Menu."]];

player createDiaryRecord["Diary", ["WBE: Balance", "

<br/> LF Balance
<br/> ---------------------------------------
<br/> Unit  Cost  UpgradeLevel ChangedLoadout  
<br/> OPFOR
<br/> BLUEFOR
<br/> Avenger 1200 2
<br/> Stryker_M2 1650 1
<br/> Stryker_Mk19 1950 1
<br/> 
<br/> HF Balance
<br/> ---------------------------------------
<br/> Unit  Cost  UpgradeLevel ChangedLoadout <br/>  
<br/> OPFOR
<br/> BLUEFOR
<br/> M6_Linebacker  6200 2  -8Stingers +8Sidewinders
<br/> Stryker_TOW 2650 0
<br/> Stryker_MGS 2950 0
<br/>
<br/> AF Balance
<br/> ---------------------------------------
<br/> ALL COMBAT JET AVAILABLE ONLY ON 3 LEVEL
<br/>
<br/> Unit  Cost  UpgradeLevel ChangedLoadout
<br/> OPFOR
<br/> Ka52      29000  2  -8 vikhr, +8 ataka
<br/> Ka52Black 32000  3  -8 vikhr, +8 ataka, +2 R73
<br/> Su34      45000  3
<br/> Su39      42400  3
<br/> L39       27700  3
<br/> su25tak   42400  3
<br/> An-2       7200  1  +4 FAB-250 +60 Flares
<br/>
<br/> BLUEFOR
<br/> AH1Z      33000 2
<br/> AH64D     30000 2
<br/> F35       41500 2 -2GBU +2Mavericks
<br/> A-10      42500 3
<br/> AH1 Apache BAF 28500   2
<br/>"]];

player createDiaryRecord["Diary", ["WBE: Fixed Bugs", "
<br/>Fix: Do not display results at the end of the game;
<br/>Fix: Disable the capture of target only during the motion of the tanks and the selected gun D81 and M256. 
<br/>Fix: Bug with patrols. Patrols does not appear due script error;
<br/>
<br/>Many scripts was optimized to increase perfomance. Less server lags, more game fun.
"]];

player createDiaryRecord["Diary", ["WBE: Gameplay", "
<br/>Aircrafts:
<br/>* The ability to buy planes only in the airport hangar;
<br/>* Ability can refuel, rearm in the hangars of the airport;
<br/>* Aircraft Flares are only available after upgrading.
<br/>* Camera follow to missiles shooted from aircraft (Settings: Default Off)
"]];

player createDiaryRecord["Diary", ["WBE: Artillery", "
<br/>* Notification when the target is out of range or how many art weapons can hit a target.
<br/>* Trace the flight shell, taking into account the terrain. Shell can not reach the goal if faced with the surface
<br/>* Use either low or high ballistic trajectory of a Shell (settings).
<br/>* When using a low ballistic artillery becomes less cheat.
<br/>  To successfully hit a target you want to borrow and to place artillery on the heights;
<br/>  This makes it easy to place bases in areas inaccessible or difficult accessible to artillery, for example in canyons (Takistan)
<br/>* Fix: Artillery does not work with latest beta patch.
"]];

player createDiaryRecord["Diary", ["WBE: Bounty Hunters", "
<br/>* When a player kills a player's opponent (not AI), the player receives reward, which amounts to 5-15% cash 
killed player (depending on player scored at the time), and the killed player loses paid a reward. 
<br/>* The maximum reward is $ 5000. 
<br/>* In case of the killed player cash less than $ 1000 - money is not paid.
<br/>
<br/>* If a player kills a player, the player loses 10% of their money as compensation for killed player. Minimum compensation of $ 500. 
<br/>
<br/>* The reward for killing enemy commander: 75% cash commander. Killed player loses the paid reward. 
<br/>* The reward for the destruction of the enemy's HQ: $ 25000 
<br/>* The reward for the destruction of the enemy's factory: $ 5000
"]];

player createDiaryRecord["Diary", ["WBE: Protecting Factories", "
<br/>* Protection depend how much product 'Stones' hold factory stock. So player can buy product 'Stones' at city and sell it at factory.
<br/>* The more product 'Stones' contain plant the stronger the protection of the factory. 
<br/>* Protection applies only to factories which contains stones, not all plants side. 
<br/>* The strength increases by 100% for every 100 tons, which are stored in a factory warehouse; 
<br/>* When attacking factories amount of stones is reduced by the amount of damage;
<br/>* Restrictions on the maximum level of protection not - depends on the quantity of stones in stock;
<br/>
<br/>- Factory without stones in stock, destroyed as usual with a 1-2 SMAW;
<br/>- Factory with 100t of stones has increased strength by 2 times and destroyed with a 2-4 SMAW;
<br/>- Factory with 200t of stones has increased strength by 3 times and destroyed with a 3-5 SMAW;
"]];

player createDiaryRecord["Diary", ["WBE: Supplies Purchase / Sale", "
<br/>* The commander can buy and sell supplies from headquarters.
<br/>* HQ may sell only supplies. Other products are not available for trading.
<br/>* Only the commander can unload supplies from the HQ in the truck;
<br/>* Any player can sell supplies to any factory (amount is added to the total supply of player team)
<br/>* Any player can buy and sell supplies to the market in any city.
"]];

player createDiaryRecord["Diary", ["WBE: Buy Vehicles and Units", "
<br/>* The cost of equipment depends on the availability of stock factory necessary for its production of goods.
<br/>* Sell the goods in a warehouse can significantly reduce the price of technology.
<br/>* Goods consumed when player buy vehicles or units at this plant.
<br/>* The price includes the equipment cost of a unit (calculated dynamically based on current prices)
<br/>
<br/>* The ability to buy necessary role in the barracks:
In the last section (where the compass, map, etc.) - to buy personal DogTags.
Role is activated only when unit equipping a backpack and personal DogTags (scout, medic, engineer, hacker, commander).
Units that can not carry backpacks can buy role, but can not use it, what will be warned about the absence of the required backpack.
"]];

player createDiaryRecord["Diary", ["WBE: Towns", "
<br/>* The commander can build a base in the city. 
<br/>* The plant was built in the city provides discounts of 10-30% (depending on the current maximum SV and SV may be provided by city) 
Players can buy soldiers lekuyu and heavy equipment in a central warehouse of any captured the city (with plants of the appropriate type). 
<br/>* Cost increases depending on how far the plant (+25% for every 1000m) (the cost of transport costs for express delivery). 
<br/>* Simple construction of the city's defense. Any player can create static capacity in the captured city without a repair truck. 
"]];

player createDiaryRecord["Diary", ["WBE: Construction Menu", "
<br/>* A more accurate placement of elements in the construction menu.
<br/>* More is impossible to build something in a different building. But it is possible to construct a near minimum distance.
<br/>* Fix: Commander can restore MHQ or build something, if the commander opened the construction menu and this time the headquarters had been destroyed;
<br/>* Fix: Disabled opportunity to build outside the area of construction;
<br/>* Fix: Disabled bug that made it possible to build a defense or factory buildings, at the positions marked as unavailable for stoitelstva (red or gray);
<br/>
<br/>If the enemy is present in the city, the menu simple construction of the city's defense blocked for 5 minutes.
<br/>Mission parameter defined who can put a simple defense of the city: Nobody, Only the engineers, Anybody;
<br/>Commander can put camouflage tent on top of other objects;
"]];

player createDiaryRecord["Diary", ["WBE: Trade", "
<br/>* Ability to buy / sell various kinds of goods on the market.
<br/>* The market is available in the central bunker of any city, headquarters or factories;
<br/>* All prices are different in different cities, the smaller the stock status of the higher cost of purchase / sale.
<br/>* Each city produces some product quantities. A rate of production is arbitrary for each type of product
for each city.
<br/>* The price of the goods is not quite random - it depends on the price of goods in neighboring towns, and the volume of goods in the warehouse of the current city.
<br/>
<br/>* Vehicles can carry different amounts of load: depends on the type of transport;
<br/>* Any player can capture the traffic of other players or the enemy and sell a product which is contained in this transport.
<br/>* When a player dies or lost transport all the goods lost
"]];

player createDiaryRecord["Diary", ["Warfare Bomba Edition Summary", "
<br/>$MISSIONNAME 
<br/>build $BUILDVERSION
<br/>
<br/>Warfare is a blend of a team-based multiplayer mission and realtime strategy, where BLUFOR and OPFOR fight for the island control. Key objectives are to capture towns, defend your base and destroy the base of enemy. Both sides are lead by a commander, who influences his side's strategy. There are two kinds of resources: Supply points are used by the commander for building factories. Money is used to purchase weapons, units and vehicles.
<br/>
<br/>Home: http://code.google.com/p/arma2warfare
<br/>Downloads: http://code.google.com/p/arma2warfare/downloads/list
<br/>
<br/>Discussion: 
<br/>* http://www.gmnet.ru/forums/showthread.php?t=44944 (russian threads)
<br/>* http://wasp-team.ucoz.ru/forum/8-99-1 (russian threads)
<br/>
<br/>Join to develop:
<br/>* Just contact with coordinator on http://code.google.com/p/arma2warfare
"]];


