#include "profiler.h"
PROFILER_BEGIN("Market_GetProductValue");

Private ['_productValue'];

	//-- _container = _this select 0;
	//-- _productId = _this select 1;

	_productValue = ((_this select 0) call marketGetContainerItems) select (_this select 1);
	

PROFILER_END();
_productValue;