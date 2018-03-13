#include "parse.h"
#include <fstream>
#include <iostream>
#include <stdlib.h>
#include <unistd.h>


void parse_args(int argc, char **argv, std::string& in, std::string& out) {
  int c;

  while ((c = getopt (argc, argv, "f:o:")) != -1)
    switch (c)
      {
        case 'f':
          in = optarg;
          break;
        case 'o':
          out = optarg;
          break;
        case '?':
          if (optopt == 'f' || optopt == 'o')
            fprintf (stderr, "Option -%c requires an argument.\n", optopt);
          else if (isprint (optopt))
            fprintf (stderr, "Unknown option `-%c'.\n", optopt);
          else
            fprintf (stderr, "Unknown option character `\\x%x'.\n", optopt);
          exit(1);
        default:
          abort ();
      }
}
