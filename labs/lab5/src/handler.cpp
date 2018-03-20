#include "handler.h"
#include "utils.h"
#include "string.h"
#include <iostream>
#include <fstream>
#include <unordered_set>
#include <csignal>

using namespace std;

void signalHandler( int signum ) {
  log(to_string(signum) + " - " + strsignal(signum) + ": " + now());

  cout << "Interrupt signal (" << signum << ") received.\n";
}

void updateSignals(int signum){
  unordered_set<int> signals = {};

  ifstream infile(CONFIG);
  string line;
  while (getline(infile, line))
  {
    signals.insert(stoi(line));
  }
  infile.close();

  for (size_t i = 1; i < MAX_SIGNAL; i++) {
    if (i == SIGHUP){
      if (signals.count(i) != 0) signalHandler(SIGHUP);
    }
    else{
      if (signals.count(i) == 0) signal(i, SIG_IGN);
      else signal(i, signalHandler);
    }
  }
}
