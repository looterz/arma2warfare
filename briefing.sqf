//--- Author [ICE]
player createDiaryRecord["Diary", ["Bomba What News", "
<br/>Most features are configurabe with game parameters;
<br/> 
<br/>Trading: 
<br/>You can buy and sell various product types at market. 
<br/>Any town has market place at cental depot;
<br/>HQ and Factories has market place;
<br/>You can trade between towns or factories for get extra moneys.
<br/>Sell some products at factory can get extra features for this factory.
<br/>
<br/>Different vehicle has different free cargo;
<br/>Any player can capture or stole other player transport and sell contained products.
<br/>Note: When player die or lost transport all product stored into cargo are LOST!
<br/>
<br/>Buy / Sell Supplies:
<br/>Commander can buy at sell supplies from HQ.
<br/>HQ market can trade only supplies. Other product types are not avaible for trade.
<br/>Factory market can't trade supplies.
<br/>Any player can put supplies at any factory, but only commander can get supplies from HQ store;
<br/>Any player can buy and sell supplies at market of any town.
<br/>
<br/>Upgrade Factory protection: 
<br/>Buy stones at market of any town and sell it at factories. 
<br/>Factory strength increased to +100% foreach 100t stones that it stored;
<br/>Factory without any protection can be destroyed from 1-2 SMAW;
<br/>Factory with 100t stones (+100%) can be destroyed from 2-4 SMAW;
<br/>Factory with 200t stones (+200%) can be destroyed from 3-5 SMAW;
<br/>
<br/>Head Hunters:
<br/>When player kills enemy player, player receives an extra award, which equals 5-15%+ of victim cash (depend from player score), thus the victim loses award value. The maximum award value is $5000. But, in case when victim has cash less than $1000 the award isn't paid.
<br/>When the player kills frendly player (team kill), player loses 10% his cash, paying refund to a victim. The minimum value of refund is $500.
<br/>Award for kill enemy commander: 75% cash of commander. Killed player lose this moneys;
<br/>Award for destroy enemy HQ: $25000
<br/>Award for destroy enemy factory: $5000
<br/>
<br/>Other Features:
<br/>More carefull placement items from constuction menu. Now impossible build something inside another building. But can build near with minimal distance.
<br/>Players can buy heavy vehicles, light vehicles and solidiers in central depot of any captured town (while factories are alive). A item price will increased depend how far nearest base factory. (+25% for each 1000m)
<br/>Simple build town defenses. Players can build static defences around town, without repair truck.
<br/>Commander can build base in a town.
<br/>Factory builded in town give discounted prices 10-30% (depended current SV and max SV)
<br/>Artillery: Player notified when target out of range or how much arty guns can hit target.
<br/>Player can buy aircrafts only in airport hangars;
<br/>AI unit cost include cost of gear;
<br/>
<br/>Fixed:
<br/>Artillery does not fired with latest beta patches.
<br/>Target Lock in tank are disabled.
<br/>Flares allowed only after upgrade.
<br/>Disable ability restore mhq or build something in case when open construction menu is open and MHQ have been destoryed;
<br/>Disable ability build outside build zone; 
<br/>Fixed bug that get possible build defences and factories inside other building even when position marked as red;
"]];
player createDiaryRecord["Diary", ["Upgrades", "<br/>To be able to purchase higher levels of equipment or units, the factories need to be upgraded by the commander. The commander will need both cash and supply points to do this. He may ask for contributions from other team players to help out. Each factory has 3 levels."]];
player createDiaryRecord["Diary", ["Supplies", "<br/>Each captured town has an Actual and Potential Value. On the map you will see this represented as 2 numbers seperated by a / for example; Zelenogorsk, once captured will start as 30/120. This means that the current supplies to each player from this town is $30 per minute. Each time a supply truck arrives at the town depot its value will increase by 10. Remember though, the supply truck must be either fully loaded from the HQ or a Supply point or, have come from a town with a higher actual value. you will also receive 4 x the actual value as cash if you or one of your squad drives the truck. Supply runs should be the responsibility of all. The best way to win Warfare is to work together capping and then supping up the town before moving to another."]];
player createDiaryRecord["Diary", ["Building", "<br/>The commander builds a base. Each side starts with one Mobile Headqarters (MHQ). This is a vehicle the commander can use to build th headquarters (HQ) anywhere on the map. After the HQ is built, other buildings can be constructed. Only the commander can build factories and defenses around the base using the HQ. The HQ can also be packed up back as MHQ again and moved to another location."]];
player createDiaryRecord["Diary", ["Team", "<br/>All players and AI soldiers can buy subordinates, equipment and vehicles from the main base as well as some vehicles from the captured town forts. You can access all available facilities through the Purchase interface from inside the main base perimeter or anywhere on the map once a Command Center has been erected. Accessible supply factories are indicated by icons on right edge of the screen. If a Barracks has been built, select the Purchase Gear button to purchase weapons and ammunition. The equipment you purchase here will also be your starting kit when you respawn. In Purchase Units button, you will find a list of unit type icons along the top. Here you can buy empty or manned units from soldiers to aircraft."]];
player createDiaryRecord["Diary", ["Commander", "<br/>The Commander can be controlled either by player or by AI. He has access to extra resources and abilities: developing the base, setting objectives for teams, and defining the strategy of your side."]];
player createDiaryRecord["Diary", ["Voting", "<br/>After starting the warfare mission, you are confronted with the Vote Commander screen. Click on any name in the player list to cast your vote. If you join a game that has already started, you will not see the Vote Commander screen. A new vote for a new Commander can be started anytime using the Vote option in the Options interface. The commander assigns a mission and a role to a team leader, whether it be AI or human player. The role can include the type of equipment and vehicles the AI teams will use. Players have control of what they will use in their team. Mission is the task for the team to perform. You may disable the Commander Vote Pop-up in the Team Menu."]];
player createDiaryRecord["Diary", ["Summary", "<br/>Warfare is a blend of a team-based multiplayer mission and realtime strategy, where BLUFOR and OPFOR fight for the island control. Key objectives are to capture towns, defend your base and destroy the base of enemy. Both sides are lead by a commander, who influences his side's strategy. There are two kinds of resources: Supply points are used by the commander for building factories. Money is used to purchase weapons, units and vehicles."]];
player createDiaryRecord["Diary", ["LF Balance", "<br/> 
Unit  Cost  UpgradeLevel ChangedLoadout<br/>  
OPFOR<br/>
<br/>
BLUEFOR<br/>
Avenger 1200 2<br/>
Stryker_M2 1650 1<br/>
Stryker_Mk19 1950 1<br/>"]];
player createDiaryRecord["Diary", ["AF Balance", "<br/>ALL COMBAT JET AVAILABLE ONLY ON 3 LEVEL<br/> 
Unit  Cost  UpgradeLevel ChangedLoadout<br/>  
OPFOR<br/>
Ka52      29000  2  -8 vikhr, +8 ataka<br/>
Ka52Black 32000  3  -8 vikhr, +8 ataka, +2 R73<br/>
Su34 45000   3<br/>Su39 42400   3<br/>L39 27700  3<br/>su25takistan 42400 3<br/>An-2 7200  1  +4 FAB-250 +60 Flares<br/><br/>  BLUEFOR<br/>AH1Z 33000 2<br/>AH64D 30000 2<br/>F35 41500 2 -2GBU +2Mavericks<br/>A-10 42500 3<br/>AH1 Apache BAF 28500   2<br/>"]];
player createDiaryRecord["Diary", ["HF Balance", "<br/>Unit  Cost  UpgradeLevel ChangedLoadout <br/>  
OPFOR<br/><br/>
BLUEFOR<br/>
M6_Linebacker  6200 2  -8Stingers +8Sidewinders<br/>
Stryker_TOW 2650 0<br/>
Stryker_MGS 2950 0<br/>"]];