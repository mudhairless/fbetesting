#include once "fbe/testing.bi"
using fbe.testing

BEGIN_TEST(test_math_works)
    dim as ulong a = 1
    dim as ulong b = 2
    testing_assert_equal(3, a + b)
    testing_assert_equal(1, b - a)
    testing_assert_equal(4, b * b)
    testing_assert_equal(1, b / b)
END_TEST

addSuite("Simple Tests")
addTest("Math Works", @test_math_works)
runTests()