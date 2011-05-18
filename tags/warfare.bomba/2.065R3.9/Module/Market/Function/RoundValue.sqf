#include "profiler.h"
PROFILER_BEGIN("Market_RoundValue");
private['_value'];

_value = floor(_this / 10) * 10;

PROFILER_END();
_value;
