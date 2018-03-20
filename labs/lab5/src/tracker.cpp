#include "tracker.h"
#include <string>
#include <sys/stat.h>

#include <time.h>
#include <iostream>
#include <csignal>

using namespace std;

int mlast = 0;

bool isModified(time_t* mlast, string filename){
  struct stat result;
  if(stat(filename.c_str(), &result)==0)
  {
      time_t mod_time = result.st_mtim.tv_sec;   // Last modification in seconds
      if (mod_time > *mlast){
        *mlast = mod_time;
        return true;
      }

      return false;
  }
  // XXX
  return false;
}

void track(pid_t pid){
  time_t mlast = 0;
  string filename = "config";

  while (1) {
    if (isModified(&mlast, filename)) kill(pid, SIGHUP);
    usleep(1000000);
  }
}
