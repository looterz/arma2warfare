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

marketProductIdSupply = 0;
marketProductIdStones = 2;

Logger = { if (WF_DEBUG) then { diag_log _this; }; };


// name, unit, basePrice, maxVolumeProduced, maxProduceSpeed/min
marketProductCollection = 
[
	["Supplies", 		"t",  5000,	  15,	  1.0], // 0
 	["Food", 			"t",    10,	1000,	 10.0],	// 1
	["Stones", 			"t",    30,	1000,	 10.0], // 2
	["Textiles", 		"t",    50,	 500,	  6.5], // 3
	["Liquor/Wines", 	"t",   150,	 300,	  6.5], // 3
	["Luxuries", 		"t",   200,	 300,	  6.5], // 4
	["Oil", 			"t",   300,	 200,	  5.0], // 11
	["Gunpowder",		"t",   600,	 200,	  3.0], // 10
	["Computers", 		"t",   900,	 200,	  3.0], // 6
	["Alloys", 			"t",  1200,	 200,	  3.0], // 8
	["Machinery", 		"t",  1500,	 200,	  3.0], // 7
	["Narcotics", 		"t",  3000,	  50,	  0.5], // 5
	["Platinum", 		"kg", 600,	 100,	  3.0], // 12
	["Gold", 			"kg",  900,	 250,	  3.0], // 13
	["Gem-stones", 		"g",  2400,	  50,	  0.5]  // 14
];

marketVehicleTypes = 
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

if (local player) then {
	player addEventHandler ['Killed', { [] call marketClearPlayerCargo; } ];
};

if (isServer) then {ExecVM "Module\Market\Init_Server.sqf"};
