#include "Example.hpp"

int Example::value() {
    constexpr auto returned_value{5};
    return returned_value;
}
