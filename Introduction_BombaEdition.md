# Introduction #

This page describe main features Warfare Bomba Edition.

_Also read [Introduction to Classic Warfare](Introduction.md)_

### Gameplay: Aircrafts ###
  * The ability to buy planes only in the airport hangar;
  * Ability can refuel, rearm in the hangars of the airport;
  * Aircraft Flares are only available after upgrading.
  * Camera follow to missiles shooted from aircraft (Settings: Default Off)

### Gameplay: Artillery ###
  * Notification when the target is out of range or how many art weapons can hit a target.
  * Trace the flight shell, taking into account the terrain. Shell can not reach the goal if faced with the surface
  * Use either low or high ballistic trajectory of a Shell (settings).
  * When using a low ballistic artillery becomes less cheat.
  * To successfully hit a target you want to borrow and to place artillery on the heights;
  * This makes it easy to place bases in areas inaccessible or difficult accessible to artillery, for example in canyons (Takistan)
  * Fix: Artillery does not work with latest beta patch.

### Gameplay: Bounty Hunters ###
  * When a player kills a player's opponent (not AI), the player receives reward, which amounts to 5-15% killed player cash (depending on player scored at the time), and the killed player loses paid a reward.
  * The maximum reward is $ 5000.
  * In case of the killed player cash less than $ 1000 - money is not paid.

  * If a player kills a player, the player loses 10% of their money as compensation for killed player. Minimum compensation of $ 500.

  * The reward for killing enemy commander: 75% cash commander. Killed player loses the paid reward.
  * The reward for the destruction of the enemy's HQ: $ 25000
  * The reward for the destruction of the enemy's factory: $ 5000

### Gameplay: Protecting Factories ###
  * Protection depend how much product 'Stones' hold factory stock. So player can buy product 'Stones' at city and sell it at factory.
  * The more product 'Stones' contain plant the stronger the protection of the factory.
  * Protection applies only to factories which contains stones, not all plants side.
  * The strength increases by 100% for every 100 tons, which are stored in a factory warehouse;
  * When attacking factories amount of stones is reduced by the amount of damage;
  * Restrictions on the maximum level of protection not - depends on the quantity of stones in stock;

  * Factory without stones in stock, destroyed as usual with a 1-2 SMAW;
  * Factory with 100t of stones has increased strength by 2 times and destroyed with a 2-4 SMAW;
  * Factory with 200t of stones has increased strength by 3 times and destroyed with a 3-5 SMAW;


### Supplies Purchase / Sale ###
  * The commander can buy and sell supplies from headquarters.
  * HQ may sell only supplies. Other products are not available for trading.
  * Only the commander can unload supplies from the HQ in the truck;
  * Any player can sell supplies to any factory (amount is added to the total supply of player team)
  * Any player can buy and sell supplies to the market in any city.


### Buy Vehicles and Units ###
  * The cost of equipment depends on the availability of stock factory necessary for its production of goods.
  * Sell the goods in a warehouse can significantly reduce the price of technology.
  * Goods consumed when player buy vehicles or units at this plant.
  * The price includes the equipment cost of a unit (calculated dynamically based on current prices)

### Player Role ###
  * The ability to buy necessary role in the barracks:
  * In the last section (where the compass, map, etc.) - to buy personal DogTags.
  * Role is activated only when unit equipping a backpack and personal DogTags (scout, medic, engineer, hacker, commander).
  * Units that can not carry backpacks can buy role, but can not use it, what will be warned about the absence of the required backpack.


### Towns ###
  * The commander can build a base in the city.
  * The plant was built in the city provides discounts of 10-30% (depending on the current maximum SV and SV may be provided by city)

  * Players can buy soldiers lekuyu and heavy equipment in a central warehouse of any captured the city (with plants of the appropriate type).
  * Cost increases depending on how far the plant (+25% for every 1000m) (the cost of transport costs for express delivery).
  * Simple construction of the city's defense. Any player can create static capacity in the captured city without a repair truck.


### Construction Menu ###
  * A more accurate placement of elements in the construction menu.
  * More is impossible to build something in a different building. But it is possible to construct a near minimum distance.
  * Fix: Commander can restore MHQ or build something, if the commander opened the construction menu and this time the headquarters had been destroyed;
  * Fix: Disabled opportunity to build outside the area of construction;
  * Fix: Disabled bug that made it possible to build a defense or factory buildings, at the positions marked as unavailable for stoitelstva (red or gray);

  * If the enemy is present in the city, the menu simple construction of the city's defense blocked for 5 minutes.
  * Mission parameter defined who can put a simple defense of the city: Nobody, Only the engineers, Anybody;
  * Commander can put camouflage tent on top of other objects;


### Trade ###
  * Ability to buy / sell various kinds of goods on the market.
  * The market is available in the central bunker of any city, headquarters or factories;
  * All prices are different in different cities, the smaller the stock status of the higher cost of purchase / sale.
  * Each city produces some product quantities. A rate of production is arbitrary for each type of product for each city.
  * The price of the goods is not quite random - it depends on the price of goods in neighboring towns, and the volume of goods in the warehouse of the current city.

  * Vehicles can carry different amounts of load: depends on the type of transport;
  * Any player can capture the traffic of other players or the enemy and sell a product which is contained in this transport.
  * When a player dies or lost transport all the goods lost

## Fixed Bugs ##
  * Fix: Do not display results at the end of the game;
  * Fix: Disable the capture of target only during the motion of the tanks and the selected gun D81 and M256.
  * Fix: Bug with patrols. Patrols does not appear due script error;
  * Many scripts was optimized to increase perfomance. Less server lags, more game fun.


## Weapon Balance ##

**Light Factory Balance**

---

| **Side/Unit**    |  **Cost** | **UpgradeLevel** | **ChangedLoadout** |
|:-----------------|:----------|:-----------------|:-------------------|
| OPFOR            |           |                  |                    |
| BLUEFOR          |           |                  |                    |
| Avenger          | 1200      | 2                |                    |
| Stryker\_M2      | 1650      |1                 |                    |
| Stryker\_Mk19    | 1950      |1                 |                    |

**Heavy Factory Balance**

---

| **Side/Unit** | **Cost** | **UpgradeLevel** | **ChangedLoadout** |
|:--------------|:---------|:-----------------|:-------------------|
| OPFOR         |          |                  |                    |
| BLUEFOR       |          |                  |                    |
| M6\_Linebacker | 6200     | 2                | -8Stingers +8Sidewinders |
| Stryker\_TOW  | 2650     | 0                |                    |
| Stryker\_MGS  | 2950     | 0                |                    |

**Air Facoty Balance**

---

_ALL COMBAT JET AVAILABLE ONLY ON 3 LEVEL_

| **Side/Unit** | **Cost** | **UpgradeLevel** | **ChangedLoadout** |
|:--------------|:---------|:-----------------|:-------------------|
|OPFOR          |          |                  |                    |
| Ka52          | 29000    | 2                | -8 vikhr, +8 ataka |
| Ka52Black     | 32000    | 3                | -8 vikhr, +8 ataka, +2 [R73](https://code.google.com/p/arma2warfare/source/detail?r=73) |
| Su34          | 45000    | 3                |                    |
| Su39          | 42400    | 3                |                    |
| L39           | 27700    | 3                |                    |
| su25takistan  | 42400    | 3                |                    |
| An-2          |  7200    | 1                | +4 FAB-250 +60 Flares |
|               |          |                  |                    |
| BLUEFOR       |          |                  |                    |
| AH1Z          | 33000    | 2                |                    |
| AH64D         | 30000    | 2                |                    |
| F35           | 41500    | 2                | -2GBU +2Mavericks  |
| A-10          | 42500    | 3                |                    |
| AH1 Apache BAF  | 28500    | 2                |                    |