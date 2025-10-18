#include once "fbe/testing.bi"

using fbe.testing

' This file is part of the advanced test example, see adv_main.bas for details

BEGIN_TEST(test_one)
    testing_assert_equal(1, 1)
END_TEST

private sub register() constructor
    addSuite("Test Suite 1")
    addTest("Test One", @test_one)
end sub