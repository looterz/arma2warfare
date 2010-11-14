#include "profiler.h"
PROFILER_BEGIN("Market_Init");

marketGetNearMarketList = Compile preprocessFile "Module\Market\Client\GetNearMarketList.sqf"; 
marketClearPlayerCargo = Compile preprocessFile "Module\Market\Client\ClearPlayerCargo.sqf";
marketGetSU = Compile preprocessFile "Module\Market\Function\GetSU.sqf"; 

marketGetContainerItems = Compile preprocessFile "Module\Market\Function\GetContainerItems.sqf";
marketGetMarketProducts = Compile preprocessFile "Module\Market\Function\GetMarketProducts.sqf"; 

marketGetProductValue = Compile preprocessFile "Module\Market\Function\GetProductValue.sqf"; 
marketUpdateProductValue = Compile preprocessFile "Module\Market\Function\UpdateProductValue.sqf"; 

marketInitMarketStorage = Compile preprocessFile "Module\Market\Function\Init_MarketStorage.sqf"; 
marketUpdateProducedProduct = Compile preprocessFile "Module\Market\Function\UpdateProducedProduct.sqf";
marketUpdateMarketPrices = Compile preprocessFile "Module\Market\Function\UpdateMarketPrices.sqf";
marketNormalizePrices = Compile preprocessFile "Module\Market\Function\NormalizePrices.sqf";
marketGetUnitPrice = Compile preprocessFile "Module\Market\Function\GetUnitPrice.sqf";
marketGetUnitPriceEx = Compile preprocessFile "Module\Market\Function\GetUnitPriceEx.sqf";
marketUseResourcesToBuyUnit = Compile preprocessFile "Module\Market\Function\UseResourcesToBuyUnit.sqf";
marketGetUnitRequiredProducts = Compile preprocessFile "Module\Market\Function\GetUnitRequiredProducts.sqf";
marketGetUnitRequirementText = Compile preprocessFile "Module\Market\Function\GetUnitRequirementText.sqf";

marketProductIdSupply = 0;
marketProductIdStones = 2;

marketProductIdFood = 1;
marketProductIdTextiles = 3;
marketProductIdOil = 6;
marketProductIdGunpowder = 7;
marketProductIdComputers = 8;
marketProductIdAlloys    = 9;
marketProductIdMachinery = 10;

MARKET_PRODUCTCOLLECTION_NAME = 0;
MARKET_PRODUCTCOLLECTION_UNIT = 1;
MARKET_PRODUCTCOLLECTION_BASEPRICE = 2;
MARKET_PRODUCTCOLLECTION_MAXVOLUMEPRODUCT = 3;
MARKET_PRODUCTCOLLECTION_MAXPRODUCESPEED = 4;

// name, unit, basePrice, maxVolumeProduced, maxProduceSpeed/min
marketProductCollection = 
[
	["Supplies", 		"t",  5000,	  15,	  1.0], // 0
 	["Food", 			"t",    10,	1000,	 10.0],	// 1
	["Stones", 			"t",    30,	1000,	 10.0], // 2
	["Textiles", 		"t",    50,	 500,	  6.5], // 3
	["Liquor/Wines", 	"t",   150,	 300,	  6.5], // 4
	["Luxuries", 		"t",   200,	 300,	  6.5], // 5
	["Oil", 			"t",   300,	 200,	  5.0], // 6
	["Gunpowder",		"t",   600,	 200,	  3.0], // 7
	["Computers", 		"t",   900,	 200,	  3.0], // 8
	["Alloys", 			"t",  1200,	 200,	  3.0], // 9
	["Machinery", 		"t",  1500,	 200,	  3.0], // 10
	["Narcotics", 		"t",  3000,	  50,	  0.5], // 11
	["Platinum", 		"kg", 600,	 100,	  3.0], // 12
	["Gold", 			"kg",  900,	 250,	  3.0], // 13
	["Gem-stones", 		"g",  2400,	  50,	  0.5]  // 14
];

marketTransportVehicleTypes = 
[	["C130J", 		100, 	"t"],
	["An2_TK_EP1", 	100, 	"t"],	
	
	["UH60_Base", 	50, 	"t"],
	["Mi17_base", 	50, 	"t"],
	["MV22", 		60, 	"t"],
	
	["V3S_Base", 	30, "t"],	
	
	["WarfareReammoTruck_USMC", 60, "t"],
	["MtvrRepair", 	15, 	"t"],
	["MtvrReammo", 	15, 	"t"],
	["MtvrRefuel", 	15, 	"t"],	
	["MTVR", 		40, 	"t"],
	
	["WarfareReammoTruck_RU",   60, "t"],
	["KamazRepair", 	15, 	"t"],
	["KamazReammo", 	15, 	"t"],
	["KamazRefuel", 	15, 	"t"],	
	["Kamaz_Base", 		40, 	"t"],
	
	
	["CAManBase", 	  15, 	"kg"],
	["Bicycle", 	  15, 	"kg"],
	["Motorcycle", 	 100, 	"kg"],
	["Car", 		  10, 	"t"],
	["Tank", 		   5, 	"t"],
	["Truck", 		  15, 	"t"],
	["Plane", 		   0, 	"t"],
	["Helicopter",    10, 	"t"]	
];

if (paramVehicleComponents) then {
	marketBuildUnitProductRequire = [

		["CAManBase",   [marketProductIdFood,   0.100], [marketProductIdTextiles, 0.100],  [marketProductIdGunpowder, 0.010] ],
		["Bicycle", 	[marketProductIdAlloys, 0.010] ],
		["Motorcycle", 	[marketProductIdAlloys, 0.050], [marketProductIdOil, 0.020] ],
		["Car", 		[marketProductIdAlloys, 0.200], [marketProductIdOil, 0.050] ],
		["Truck", 		[marketProductIdAlloys, 0.500], [marketProductIdOil, 0.100] ],
		["Helicopter",  [marketProductIdAlloys, 1.000], [marketProductIdOil, 0.500], [marketProductIdGunpowder, 1.000], [marketProductIdComputers, 0.500] ],	
		["Plane", 		[marketProductIdAlloys, 1.000], [marketProductIdOil, 1.000], [marketProductIdGunpowder, 1.000], [marketProductIdComputers, 1.000] ],
		["Tank", 		[marketProductIdAlloys, 1.500], [marketProductIdOil, 1.500], [marketProductIdGunpowder, 1.000], [marketProductIdComputers, 0.250] ]
	];
} else {
	marketBuildUnitProductRequire = [];
};


if (local player) then {
	player addEventHandler ['Killed', { [] call marketClearPlayerCargo; } ];
};

if (isServer) then {ExecVM "Module\Market\Init_Server.sqf"};

PROFILER_END();