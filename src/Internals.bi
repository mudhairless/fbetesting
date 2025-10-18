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


#ifndef __FBE_TESTING_INTERNALS_BI__
#define __FBE_TESTING_INTERNALS_BI__

#include once "TestCase.bi"
#include once "TestSuite.bi"

namespace fbe.testing
    '# Helpers simplify the addition of suites and new test to each suite.
    '# you could call them directly, but is recomended (and shorter)
    '# use the defines below in this file.
    namespace Internals
        declare function suite_defined(byref as string) as boolean
        declare function test_defined(byref as string) as boolean
        declare function select_suite(byref as string) as TestSuite ptr
        declare function select_test(byref as string) as TestCase ptr

        declare function current_suite_name() as string
        declare function current_test_name() as string

        '# SELECTED_SUITE
        extern SELECTED_SUITE as TestSuite ptr

        '# SELECTED_TEST
        extern SELECTED_TEST as TestCase ptr

    end namespace 
end namespace 

#endif 
