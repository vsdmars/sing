#include "lib.hpp"

auto main() -> int
{
  library lib;

  return lib.name == "sing" ? 0 : 1;
}
