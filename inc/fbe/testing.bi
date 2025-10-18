''Title: testing.bi
''
''About: About this Module
''This is a simple Unit Testing Framework.
''You can find more information about unit testing in general at http://en.wikipedia.org/wiki/Unit_testing
''
''About: Code License
''Copyright (c) 2025, Ebben Feagan
''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''Contains code contributed and Copyright (c) 2006-2008 Luis Lavena, Multimedia systems
''
''Distributed under the MIT license. See accompanying file LICENSE for details
''
# pragma once
#ifndef __FBE_TESTING_BI__
#define __FBE_TESTING_BI__ -1

#if not __FB_MT__
    #inclib "fbetesting"
    
#else
    #inclib "fbetestingmt"
    #ifndef FBE_MULTITHREADED
        #define FBE_MULTITHREADED 1
    #endif
#endif

''namespace: fbe.testing
namespace fbe.testing

    ''Type: test_func_t
    ''Function prototype for testcases.
    ''
    type test_func_t as sub()

    ''Enum: Hook
    ''Used with addSuiteHook to run a procedure on certain events.
    ''
    ''before_all - runs this procedure before running any testcases.
    ''before_each - runs this procedure before running each testcase.
    ''after_all - runs this procedure after running all testcases.
    ''after_each - runs this procedure after each testcase.
    ''
    enum Hook explicit
        before_all
        before_each
        after_all
        after_each
    end enum

    ''Function: customAssertion
    ''Used by the helper macros below. Generally not needed to call directly.
    ''
    ''Parameters:
    ''test - boolean value indicating whether assertion was sucessful.
    ''file - string containing the file the testcase is in.
    ''line - uinteger containing the line number of the assertion.
    ''msg - string containing the message to be passed to the user if assertion fails.
    ''error - boolean value indicating true if there is an error and the suite should stop. defaults to false.
    ''
    ''Returns:
    ''boolean value indicating false if there is a fatal error. Usually ignored.
    ''
    declare function customAssertion(byval as boolean, byref as string, byval as uinteger, _
                                        byref as string, byval as boolean = false) as boolean

    '# Helpers simplify the addition of suites and new test to each suite.
    '# you could call them directly, but is recomended (and shorter)
    '# use the defines below in this file.

    ''Function: addSuite
    ''Add a test Suite.
    ''
    ''Parameters:
    ''name - string containing the name of the test suite to add, used in error reporting.
    ''
    ''Returns:
    ''True if sucessful.
    ''
    declare function addSuite(byref as string) as boolean

    ''Function: addSuiteHook
    ''Assign a function to run at certain points in the suite.
    ''
    ''Parameters:
    ''hooktype - see <Hook>
    ''proc - function to run at specified time.
    ''
    ''Returns:
    ''True if procedure is added.
    ''
    declare function addSuiteHook(byval as Hook, byref as sub()) as boolean

    ''function: addTest
    ''Adds a testcase to the testsuite.
    ''
    ''Parameters:
    ''name - string containing the name of the testcase.
    ''proc - procedure containing the testcase.
    ''
    ''Returns:
    ''True if testcase is added.
    ''
    declare function addTest(byref as string, byref as test_func_t) as boolean

    ''Function: runTests
    ''Runs the testcases for all registered Suites.
    ''
    ''Returns:
    ''True on success.
    ''
    declare function runTests() as boolean

end namespace

''Macro: BEGIN_TEST
''Signifies the start of a test subroutine
''
''Parameters:
''name - the name of the test subroutine
''
#define BEGIN_TEST(__name__) private sub __name__ ()

''Macro: END_TEST
''Signifies the end of a test subroutine
''
#define END_TEST end sub


''Section: Available Test Assertations

''Macro: testing_assert_true
''
''Parameters:
''value - value that should equal a boolean true
''
#define testing_assert_true(__value__) _
        fbe.testing.customAssertion((true) = (__value__), __FILE__, __LINE__, ("{" #__value__ "} is not true."))

''Macro: testing_assert_true_error
''
''Parameters:
''value - value that should equal a boolean true or an error will be issued and the current test will be ended early
''
#define testing_assert_true_error(__value__) _
        if (fbe.testing.customAssertion((true) = (__value__), __FILE__, __LINE__, ("{" #__value__ "} is not true."), true) = false) then exit sub

''Macro: testing_assert_false
''
''Parameters:
''value - value that should equal a boolean false
''
#define testing_assert_false(__value__) _
        fbe.testing.customAssertion((false) = (__value__), __FILE__, __LINE__, ("{" #__value__ "} is not false."))

''macro: testing_assert_false_error
''
''Parameters:
''value - value that should equal a boolean false or an error will be issued and the current test will be ended early
''
#define testing_assert_false_error(__value__) _
        if (fbe.testing.customAssertion((false) = (__value__), __FILE__, __LINE__, ("{" #__value__ "} is not false."), true) = false) then exit sub

''macro: testing_assert_equal
''Use to test non string values are equal
''
''Parameters:
''expected - the value that your test should produce
''actual - the actual value your test produced
''
#define testing_assert_equal(__expected__, __actual__) _
        fbe.testing.customAssertion((__actual__) = (__expected__), __FILE__, __LINE__, ("expected {" #__expected__ "} but was {" #__actual__ "}"))

''macro: testing_assert_equal_error
''Use to test non string values are equal, if not equal an error will be raised and the current test will end early
''
''Parameters:
''expected - the value that your test should produce
''actual - the actual value your test produced
''
#define testing_assert_equal_error(__expected__, __actual__) _
        if (fbe.testing.customAssertion((__actual__) = (__expected__), __FILE__, __LINE__, ("expected {" #__expected__ "} but was {" #__actual__ "}"), true) = false) then exit sub

''macro: testing_assert_not_equal
''Use to test non string values are not equal
''
''Parameters:
''expected - the value that your test should produce
''actual - the actual value your test produced
''
#define testing_assert_not_equal(__expected__, __actual__) _
        fbe.testing.customAssertion((__actual__) <> (__expected__), __FILE__, __LINE__, ("{" #__actual__ "} expected to be != to {" #__expected__ "}"))

''macro: testing_assert_not_equal_error
''Use to test non string values are not equal, if equal an error will be raised and the current test will end early
''
''Parameters:
''expected - the value that your test should produce
''actual - the actual value your test produced
''
#define testing_assert_not_equal_error(__expected__, __actual__) _
        if (fbe.testing.customAssertion((__actual__) <> (__expected__), __FILE__, __LINE__, ("{" #__actual__ "} expected to be != to {" #__expected__ "}"), true) = false) then exit sub

''macro: testing_assert_string_equal
''Use to test string values are equal
''
''Parameters:
''expected - the value that your test should produce
''actual - the actual value your test produced
''
#define testing_assert_string_equal(__expected__, __actual__) _
        fbe.testing.customAssertion((str(__actual__) = str(__expected__)), __FILE__, __LINE__, ("expected {" & __expected__ & "} but was {"& __actual__ &"}"))

''macro: testing_assert_string_equal_error
''Use to test  string values are equal, if not equal an error will be raised and the current test will end early
''
''Parameters:
''expected - the value that your test should produce
''actual - the actual value your test produced
''
#define testing_assert_string_equal_error(__expected__, __actual__) _
        if (fbe.testing.customAssertion((str(__actual__) = str(__expected__)), __FILE__, __LINE__, ("expected {" & __expected__ & "} but was {" & __actual__ & "}"), true) = false) then exit sub

''macro: testing_assert_string_not_equal
''Use to test string values are not equal
''
''Parameters:
''expected - the value that your test should produce
''actual - the actual value your test produced
''
#define testing_assert_string_not_equal(__expected__, __actual__) _
        fbe.testing.customAssertion((str(__actual__) <> str(__expected__)), __FILE__, __LINE__, ("{" & __actual__ & "} expected to be != to {" & __expected__ & "}"))

''macro: testing_assert_string_not_equal_error
''Use to test string values are not equal, if equal an error will be raised and the current test will end early
''
''Parameters:
''expected - the value that your test should produce
''actual - the actual value your test produced
''
#define testing_assert_string_not_equal_error(__expected__, __actual__) _
        if (fbe.testing.customAssertion((str(__actual__) <> str(__expected__)), __FILE__, __LINE__, ("{" & __actual__ & "} expected to be != to {" & __expected__ & "}"), true) = false) then exit sub

''macro: testing_assert_pass
''Used by more complex tests to indicate that the test was successful
''
''Parameters:
''message - the message for this test passing
''
#define testing_assert_pass(__message__) _
        fbe.testing.customAssertion((true), __FILE__, __LINE__, __message__)

''macro: testing_assert_fail
''Used by more complex tests to indicate that the test was not successful
''
''Parameters:
''message - the message explaining how this test failed
''
#define testing_assert_fail(__message__) _
        fbe.testing.customAssertion((false), __FILE__, __LINE__, __message__)

''macro: testing_assert_error
''Used by more complex tests to indicate that there was an error during the test, exits the test early
''
''Parameters:
''message - the message explaining how this test errored
''
#define testing_assert_error(__message__) _
        if (fbe.testing.customAssertion((false), __FILE__, __LINE__, __message__, true) = false) then exit sub

#endif 
