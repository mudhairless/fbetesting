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


#ifndef __FBE_TESTING_TESTSUITE_BI__
#define __FBE_TESTING_TESTSUITE_BI__

#include once "fbe/testing.bi"
#include once "GenericList.bi"

namespace fbe.testing
    '# AssertCount is used to store results of the Suite
    type AssertCount
        assertions as ulong
        failures as ulong
        errors as ulong
    end type

    '# TestSuite defines a list of test to be processed
    '# also, it could offer a setup and teardown functionality before and after running the
    '# tests defined.
    '# results (counts) are collected in stats (AssertCount)
    '# this suite can also be excluded from results and failures/errors collecting process
    '# useful for internal testing.
    type TestSuite
        declare constructor(byref as string = "")
        declare destructor()

        suite_name as string

        before_all as sub()
        before_each as sub()
        after_each as sub()
        after_all as sub()

        declare property tests_count as ulong

        exclude as boolean
        tests_list as GenericList ptr
        stats as AssertCount
    end type

end namespace 

#endif 
