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


#include once "Internals.bi"
#include once "Common.bi"

namespace fbe.testing
    namespace InternalHelpers
        dim shared SELECTED_SUITE as TestSuite ptr
        dim shared SELECTED_TEST as TestCase ptr

        '#############################################################
        '# defined and select helpers
        '# these helpers allow internal testing of the library
        '# you could use them directly, but the best approach is use
        '# the defines
        '#
        '# suite_defined_helper will return true in suite_name is found
        function suite_defined(byref suite_name as string) as boolean
            dim result as boolean
            dim item as TestSuite ptr

            item = find_suite(SUITES_LIST, suite_name)
            if not (item = 0) then
                result = true
            end if

            return result
        end function


        '# test_defined_helper will return true in test_name is found
        function test_defined(byref test_name as string) as boolean
            dim result as boolean
            dim item as TestCase ptr

            '# test_defined works only on the SELECTED_SUITE!!!
            if not (SELECTED_SUITE = 0) then
                item = find_test(SELECTED_SUITE->tests_list, test_name)
                if not (item = 0) then
                    result = true
                endif
            end if

            return result
        end function


        '# select_suite_helper return a pointer to the suite_name structure
        function select_suite(byref suite_name as string) as TestSuite ptr
            dim result as TestSuite ptr

            result = find_suite(SUITES_LIST, suite_name)
            SELECTED_SUITE = result

            return result
        end function


        '# select_test_helper return a pointer to the test_name structure
        function select_test(byref test_name as string) as TestCase ptr
            dim result as TestCase ptr

            result = find_test(SELECTED_SUITE->tests_list, test_name)
            SELECTED_TEST = result

            return result
        end function


        '# current_suite_name_helper return a plain string with the current suite name
        function current_suite_name() as string
            dim result as string

            if not (RUNNING_SUITE = 0) then
                result = RUNNING_SUITE->suite_name
            end if

            return result
        end function


        '# current_test_name_helper return a plain string with the current test name
        function current_test_name() as string
            dim result as string

            if not (RUNNING_TEST = 0) then
                result = RUNNING_TEST->test_name
            end if

            return result
        end function

    end namespace 'InternalHelpers
end namespace 'Testly
