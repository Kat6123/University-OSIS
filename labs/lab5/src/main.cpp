#include "daemon.h"

using namespace std;

int main (int argc, char **argv)
{
  createDaemon();
  startDaemon();

  return 0;
}
