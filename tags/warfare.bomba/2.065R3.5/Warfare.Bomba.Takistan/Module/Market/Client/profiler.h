#define PROFILER_BEGIN(funcName) 	private "_profiler"; \
									_profiler = ##funcName call ProfilerBegin;
#define PROFILER_END() _profiler call ProfilerEnd;