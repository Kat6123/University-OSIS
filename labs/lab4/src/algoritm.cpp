#include "algoritm.h"
#include <algorithm>
#include <iostream>


using namespace std;


void reverse_stream() {
  string line;
  while (getline( cin, line ))
    {
        reverse(line.begin(), line.end());
        cout << line << endl;
    }
}
