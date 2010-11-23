#include "profiler.h"

	while { !gameOver } do {
		sleep 10;
		[] call BuyUnit_OrderQueueProcessing;
	};
