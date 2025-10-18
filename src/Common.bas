''Copyright (c) 2025, Ebben Feagan
''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''Copyright (c) 2006-2008 Luis Lavena, Multimedia systems
''
'' All rights reserved.
''
'' Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
''
''  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
''  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
''  * Neither the name of the copyright holders nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
''
'' THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
'' "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
'' LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
'' A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
'' CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
'' EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
'' PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
'' PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
'' LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
'' NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
'' SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#include once "Common.bi"

namespace fbe.testing
    dim shared SUITES_LIST as GenericList ptr
    dim shared FAILURES_LIST as GenericList ptr
    dim shared RUNNING_SUITE as TestSuite ptr
    dim shared RUNNING_TEST as TestCase ptr


    '# initialize() prepare Testly to be used by the user
    '# it creates the GenericList that will hold all the suites
    '# for safety, this was marked as private
    sub initialize() constructor
        '# construct the list that will hold the suites
        if SUITES_LIST = null then
            SUITES_LIST = new GenericList
        end if

        '# the failures list
        if FAILURES_LIST = null then
            FAILURES_LIST = new GenericList
        end if
    end sub


    '# terminate() ensures all the suites are removed from SUITES_LIST
    '# prior removing it.
    private sub terminate() destructor
        dim node_suite as TestSuite ptr
        dim node_failure as FailureLog ptr

        '# ensure all the Suites being removed
        do while (SUITES_LIST->count > 0)
            node_suite = cast(TestSuite ptr, SUITES_LIST->shift())
            delete node_suite
        loop

        '# ensure removing all the logged failures
        do while (FAILURES_LIST->count > 0)
            node_failure = cast(FailureLog ptr, FAILURES_LIST->shift())
            delete node_failure
        loop

        '# remove the global GenericList
        delete SUITES_LIST

        '# remove failure list
        delete FAILURES_LIST

        '# cleanup, just in case
        RUNNING_SUITE = 0
        RUNNING_TEST = 0
    end sub


    function customassertion(byval assert_value as boolean, byref filename as string, byval linenumber as uinteger, _
                                byref message as string, byval fatal_error as boolean = false) as boolean
        dim result as boolean

        '# we must first ensure we aren't doing assertions like crazy,
        '# like outside of runTests()...
        if not (RUNNING_SUITE = 0) then
            '# increment the current suite assertions
            RUNNING_SUITE->stats.assertions += 1

            '# the assert_value is meet?
            if (assert_value = false) then
                '# no, log it.
                '# see if it is fatal and adjust the assertion stats
                if (fatal_error = true) then
                    RUNNING_SUITE->stats.errors += 1
                    result = false
                else
                    RUNNING_SUITE->stats.failures += 1
                    result = true
                end if

                '# log it only if CURRENT_SUITE is not excluded
                if not (RUNNING_SUITE->exclude = true) then
                    '# check if this assertion happens inside a test or in the setup/teardown mechanism
                    if not (RUNNING_TEST = 0) then
                        log_failure(RUNNING_SUITE->suite_name, RUNNING_TEST->test_name, filename, linenumber, message, fatal_error)
                    else
                        log_failure(RUNNING_SUITE->suite_name, "", filename, linenumber, message, fatal_error)
                    end if
                end if
            end if
        end if

        return result
    end function


    function log_failure(byref suite_name as string, byref test_name as string, byref filename as string, _
                    byval linenumber as uinteger, byref message as string, byval is_error as boolean = false) as boolean

        dim result as boolean
        dim failure as FailureLog ptr

        if not (FAILURES_LIST = 0) then
            '# create a new failure log
            failure = new FailureLog
            with *failure
                .suite_name = suite_name
                .test_name = test_name
                .filename = filename
                .linenumber = linenumber
                .message = message
                .is_error = is_error
            end with

            FAILURES_LIST->add(failure)
            result = true
        else
            result = false
        end if

        return result
    end function


    '#############################################################
    '# find_* helpers
    '# find_suite will look into 'in_list' GenericList for suite_name
    '# if no suite is found, return 0
    function find_suite(byval in_list as GenericList ptr, byref suite_name as string) as TestSuite ptr
        dim result as TestSuite ptr
        dim node as ListNode ptr
        dim item as TestSuite ptr
        dim found as boolean

        result = 0

        if not (in_list = 0) then
            node = in_list->first
            do until (node = 0) or (found = true)
                item = cast(TestSuite ptr, node->value)
                if (item->suite_name = suite_name) then
                    found = true
                else
                    node = node->next
                end if
            loop

            if (found = true) then
                result = item
            else
                result = 0
            end if
        end if

        return result
    end function


    '# find_test will look into 'in_list' GenericList for test_name
    '# if no test is found, return 0
    function find_test(byval in_list as GenericList ptr, byref test_name as string) as TestCase ptr
        dim result as TestCase ptr
        dim node as ListNode ptr
        dim item as TestCase ptr
        dim found as boolean

        result = 0

        if not (in_list = 0) then
            node = in_list->first
            do until (node = 0) or (found = true)
                item = cast(TestCase ptr, node->value)
                if (item->test_name = test_name) then
                    found = true
                else
                    node = node->next
                end if
            loop

            if (found = true) then
                result = item
            else
                result = 0
            end if
        end if

        return result
    end function

end namespace 
