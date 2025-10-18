#include once "fbe/testing.bi"

using fbe.testing

' This file is part of the advanced test example, see adv_main.bas for details

BEGIN_TEST(test_two)
    testing_assert_equal(2, 2)
END_TEST

private sub register() constructor
    addSuite("Test Suite 2")
    addTest("Test Two", @test_two)
end sub