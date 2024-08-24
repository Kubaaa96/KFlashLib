#include <fmt/core.h>
#include "Example.hpp"

int main(){
    fmt::print("Hello World {}\n", Example::value());
}