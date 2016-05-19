// check if on linux machine
#ifdef __linux__
#include <utmpx.h>
int sched_getcpu();
#endif

int findmycpu_()
{
#ifdef __linux__
  int cpu;
  cpu = sched_getcpu();
  return cpu;
#else
  return -1;
#endif
}
