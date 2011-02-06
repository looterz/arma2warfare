#include "profiler.h"
PROFILER_BEGIN("Market_ChangeCargoProductValue");

private['_productId','_dV','_product','_cargoinfo','_cargo','_volume','_producttype','_productsu','_cargofreespacesu','_data'];

	format["ChangeCargoProductValue: _this: %1", _this] call LogHigh;

	_cargo = _this select 0;
	_productType = _this select 1;
	_dV = _this select 2;
	
	if (isNil "_cargo") exitWith { [false, "UndefinedCargo"] };
	
	if (_dV == 0) exitWith { [true] };
	
	_productId = _productType call marketGetProductIdByType;
	if (_productId == -1) exitWith { [false, "UnknownProduct"] };

	_cargoInfo = _cargo call marketGetCargoInfo;
	_volume = ((_cargoInfo select 1) select _productId) + _dV;

	if (_volume < 0) exitWith { [false, "NoEnoughProductCount"] };

	_product = marketProductCollection select _productId;
	_productSU = _product call marketGetSU;	

	_cargoFreeSpaceSU = (_cargoInfo select 3) + _dV * _productSU;

	if (_cargoFreeSpaceSU < 0) exitWith { [false, "NoEnougtFreeSpace"] };

	_data = [(_cargoInfo select 0), _productId, _dV];
	_data call marketUpdateProductValue;
	

	format["ChangeCargoProductValue: _cargoInfo: %1", _cargoInfo] call LogHigh;
	format["ChangeCargoProductValue: _data: %1", _data] call LogHigh;
	
PROFILER_END();
[true, format["Successfully Loaded: %1", _volume]];