#include "profiler.h"
PROFILER_BEGIN("Market_GetProductIdByType");

Private ['_productName', "_productId"];

	_productName = _this;
	_productId = marketProductTypes find _productName;

PROFILER_END();
_productId;