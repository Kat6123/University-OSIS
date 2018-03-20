#include "daemon.h"
#include "utils.h"
#include "tracker.h"
#include "handler.h"
#include <unistd.h>
#include <iostream>
#include <csignal>
#include <thread>

using namespace std;

int startDaemon(){
  signal(SIGHUP, updateSignals);

  pid_t pid = getpid();
  thread tracker(track, pid);

  while(1) {
   usleep(1000000);
  }
  tracker.join();
  return 0;
}

void createDaemon(){
  pid_t pid;
  pid = fork();

  cout << pid << endl;
  /* An error occurred */
  if (pid < 0)
      exit(EXIT_FAILURE);

  /* Success: Let the parent terminate, 0 for child */
  if (pid > 0)
      exit(EXIT_SUCCESS);

  /* On success: The child process becomes session leader */
  if (setsid() < 0)
      exit(EXIT_FAILURE);

  /* Close all open file descriptors */
  int x;
  for (x = sysconf(_SC_OPEN_MAX); x>=0; x--)
  {
      close (x);
  }

  log("Start daemon " + to_string(getpid()) + "\n");
}
