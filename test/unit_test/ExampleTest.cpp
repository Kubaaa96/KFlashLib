#include "gtest/gtest.h"
#include "Example.hpp"


struct ExampleTest : testing::Test {
    public:

};

TEST_F(ExampleTest, first_test) {
    // given

    // when
    auto actual_value = Example::value();

    // then
    constexpr auto expected_value{5};

    ASSERT_EQ(actual_value, expected_value);
}