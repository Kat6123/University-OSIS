#include "algoritm.h"
#include "parse.h"
#include <iostream>
#include <fstream>

using namespace std;


int main (int argc, char **argv)
{
  string min = "cin";
  string mout = "cout";
  parse_args(argc, argv, min, mout);

  if (min != "cin") freopen(min.c_str(),"r",stdin);
  if (mout != "cout") freopen(mout.c_str(),"w",stdout);

  reverse_stream();

  return 0;
}
