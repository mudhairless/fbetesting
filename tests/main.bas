#include once "fbe/testing.bi"

using fbe.testing

BEGIN_TEST(test_assert_equal)
    var a = 10, b = 10
    testing_assert_equal(a, b)
    var stringA = "Part", stringB = "One"
    testing_assert_string_equal("PartOne", stringA + stringB)
END_TEST

BEGIN_TEST(test_assert_equal_fail)
    var a = 10, b = 10
    testing_assert_equal(a, b+10)
    var stringA = "Part", stringB = "Two"
    testing_assert_string_equal("PartOne", stringA + stringB)
END_TEST

BEGIN_TEST(test_assert_equal_fail_with_error)
    var a = 10, b = 10
    testing_assert_equal_error(a, b+10)
    var stringA = "Part", stringB = "Two"
    testing_assert_string_equal_error("PartOne", stringA + stringB)
END_TEST

BEGIN_TEST(test_assert_not_equal)
    var a = 10, b = 20
    testing_assert_not_equal(a, b)
    var stringA = "Part", stringB = "Two"
    testing_assert_string_not_equal("PartOne", stringA + stringB)
END_TEST

BEGIN_TEST(test_assert_not_equal_fail)
    var a = 10, b = 10
    testing_assert_not_equal(a, b)
    var stringA = "Part", stringB = "One"
    testing_assert_string_not_equal("PartOne", stringA + stringB)
END_TEST

BEGIN_TEST(test_assert_not_equal_fail_with_error)
    var a = 10, b = 10
    testing_assert_not_equal_error(a, b)
    var stringA = "Part", stringB = "One"
    testing_assert_string_not_equal_error("PartOne", stringA + stringB)
END_TEST

BEGIN_TEST(test_assert_bool)
    testing_assert_true(true AND true)
    testing_assert_false(true AND false)
END_TEST

BEGIN_TEST(test_assert_bool_fail)
    testing_assert_true(true XOR true)
    testing_assert_false(true AND true)
END_TEST

BEGIN_TEST(test_assert_bool_fail_with_error)
    testing_assert_true_error(true XOR true)
    testing_assert_false_error(true AND true)
END_TEST

BEGIN_TEST(test_assert_pass)
    testing_assert_pass("This Test Passed")
END_TEST

BEGIN_TEST(test_assert_fail)
    testing_assert_fail("This Test Passed")
END_TEST

BEGIN_TEST(test_assert_error)
    testing_assert_error("This Test Passed")
END_TEST

addSuite("Test Assertations")
addTest("testing_assert_equal", @test_assert_equal)
addTest("testing_assert_not_equal", @test_assert_not_equal)
addTest("testing_assert_(booleans)", @test_assert_bool)
addTest("testing_assert_pass", @test_assert_pass)

addSuite("Test Assertation Failures")
addTest("testing_assert_equal_fails", @test_assert_equal_fail)
addTest("testing_assert_not_equal_fails", @test_assert_not_equal_fail)
addTest("testing_assert_(booleans)_fails", @test_assert_bool_fail)
addTest("testing_assert_fail", @test_assert_fail)

addSuite("Test Assertation Failures that Error")
addTest("testing_assert_equal_fails", @test_assert_equal_fail_with_error)
addTest("testing_assert_not_equal_fails", @test_assert_not_equal_fail_with_error)
addTest("testing_assert_(booleans)_fails", @test_assert_bool_fail_with_error)
addTest("testing_assert_error", @test_assert_error)

runTests()