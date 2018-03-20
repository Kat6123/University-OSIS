#include "utils.h"
#include <chrono>
#include <ctime>
#include <fstream>

char* now(){
  std::chrono::system_clock::time_point today = std::chrono::system_clock::now();
  time_t tt;
  tt = std::chrono::system_clock::to_time_t ( today );

  return ctime(&tt);
}

void log(std::string msg){
  std::ofstream outfile;
  outfile.open(LOG, std::ios_base::app);
  outfile << msg;
  outfile.close();
}
