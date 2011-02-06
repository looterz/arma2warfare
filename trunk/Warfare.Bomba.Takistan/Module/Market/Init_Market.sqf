private['_u','_weight','_defensetypes','_productinfo','_cost','_productid','_max','_fninitdefenseproduct','_d','_product','_prodspeed'];

#include "profiler.h"
PROFILER_BEGIN("Market_Init");

marketGetNearMarketList = Compile preprocessFile "Module\Market\Client\GetNearMarketList.sqf"; 
marketClearPlayerCargo = Compile preprocessFile "Module\Market\Client\ClearPlayerCargo.sqf";
marketGetSU = Compile preprocessFile "Module\Market\Function\GetSU.sqf"; 

marketGetContainerItems = Compile preprocessFile "Module\Market\Function\GetContainerItems.sqf";
marketSetContainerItems = Compile preprocessFile "Module\Market\Function\SetContainerItems.sqf";

marketGetMarketProducts = Compile preprocessFile "Module\Market\Function\GetMarketProducts.sqf"; 
marketGetMarketPrices = Compile preprocessFile "Module\Market\Function\GetMarketPrices.sqf"; 

marketGetProductValue = Compile preprocessFile "Module\Market\Function\GetProductValue.sqf"; 
marketGetProductIdByType = Compile preprocessFile "Module\Market\Function\GetProductIdByType.sqf";
marketUpdateProductValue = Compile preprocessFile "Module\Market\Function\UpdateProductValue.sqf"; 

marketInitMarketStorage = Compile preprocessFile "Module\Market\Function\Init_MarketStorage.sqf"; 
marketUpdateProducedProduct = Compile preprocessFile "Module\Market\Function\UpdateProducedProduct.sqf";
marketUpdateMarketPrices = Compile preprocessFile "Module\Market\Function\UpdateMarketPrices.sqf";
marketNormalizePrices = Compile preprocessFile "Module\Market\Function\NormalizePrices.sqf";

marketChangeCargoProductValue = Compile preprocessFile "Module\Market\Function\ChangeCargoProductValue.sqf";

marketRoundValue = Compile preprocessFile "Module\Market\Function\RoundValue.sqf";
marketGetCargoInfo = Compile preprocessFile "Module\Market\Function\GetCargoInfo.sqf";

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

// name, unit, basePrice, maxVolumeProduced, maxProduceSpeed/min, weight per unit (kg), sideId
marketProductCollection = 
[
	["Supplies", 			"t", 	  5000,	  	  15,  1.0, 1, -1], // 0
	["Shields", 			"t",    	30,		1000, 10.0, 1, -1]  // 2
];

waitUntil { commonInitComplete };

format["Init_Market: %1", ("WFBE_WESTDEFENSENAMES" Call GetNamespace)] call LogHigh;



_fnInitDefenseProduct = {
	private["_defenses", "_sideId"];
	
	_defenses = _this select 0;
	_sideId = _this select 1;
	
	{
			_productId = _defenseTypes find _x;
			if (_productId != -1) then {
				_product = marketProductCollection select _productId;
				_product set [6, 0]; // set sideId Any;
			};

			_d = _x Call GetNamespace;
			
			format["Init_Market: %1, %2", _x, _d] call LogHigh;

			
			if (!isNil '_d' && _productId == -1) then {
				_cost = _d select QUERYUNITPRICE;
				_defenseTypes = _defenseTypes + [_x];
				
				_max = ceil( 10 * 2400 / _cost ); //  max town can contain 10 cannons
				_prodSpeed = ceil( (1 / 5) * 2400 / _cost );	// town can produce 1 cannon at 5 mins
				_weight    = ceil( 5000 / (2400 / _cost) );
				
				if (_max > 100) then { _max = 100; };
				
				if (_weight < 250) then { _weight = 250; };
				if (_weight > 1000) then { _weight = floor(_weight / 1000) * 1000 };
				if (_weight > 250) then { _weight = floor(_weight / 250) * 250 };
				if (_weight > 10000) then { _weight = 10000 };
				
				marketProductCollection = marketProductCollection + [ [_x, "piece", _cost, _max, _prodSpeed, _weight, _sideId] ];
			};

	} forEach _defenses;	
	
};

_defenseTypes = [];
["WFBE_WESTDEFENSENAMES" Call GetNamespace, WESTID, _defenseTypes] call _fnInitDefenseProduct;
["WFBE_EASTDEFENSENAMES" Call GetNamespace, EASTID, _defenseTypes] call _fnInitDefenseProduct;


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
	
	["CAManBase", 	  15, 	if (WF_DEBUG) then { "t"} else {"kg"} ],
	["Bicycle", 	  15, 	"kg"],
	["Motorcycle", 	 100, 	"kg"],
	["Car", 		  10, 	"t"],
	["Tank", 		   5, 	"t"],
	["Truck", 		  15, 	"t"],
	["Plane", 		   0, 	"t"],
	["Helicopter",    10, 	"t"]	
];

marketTotalProductCount = count marketProductCollection;

marketEmptyContainer = [];
marketEmptyPriceList = [];
marketProductTypes   = [];

_u = 0;
while { _u < marketTotalProductCount } do {
	marketEmptyContainer = marketEmptyContainer + [0];
	marketEmptyPriceList = marketEmptyPriceList + [[-1, -1]];
	marketProductTypes   =  marketProductTypes + [ (marketProductCollection select _u) select 0 ];
	_u = _u + 1;	
};


if (local player) then {
	player addEventHandler ['Killed', { [] call marketClearPlayerCargo; } ];
};

//------------------
// rebuild array to separate array list for increase perfomance
marketProductNameCollection = [] + marketEmptyContainer;
marketProductUnitCollection = [] + marketEmptyContainer;
marketProductBasePriceCollection = [] + marketEmptyContainer;
marketProductMaxProduceVolumeCollection = [] + marketEmptyContainer;
marketProductMaxProduceSpeedCollection = [] + marketEmptyContainer;

_u = marketTotalProductCount;
while { _u != 0 } do {
	_u = _u - 1;
	_productInfo = marketProductCollection select _u; 
	marketProductNameCollection set[_u, _productInfo select 0];
	marketProductUnitCollection set[_u, _productInfo select 1];
	marketProductBasePriceCollection set[_u, _productInfo select 2];
	marketProductMaxProduceVolumeCollection set[_u, _productInfo select 3];
	marketProductMaxProduceSpeedCollection set[_u, _productInfo select 4];
};


if (isServer) then {ExecVM "Module\Market\Init_Server.sqf"};

PROFILER_END();