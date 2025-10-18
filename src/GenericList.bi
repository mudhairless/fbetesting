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


#ifndef __FBE_TESTING_GENERICLIST_BI__
#define __FBE_TESTING_GENERICLIST_BI__

namespace fbe.testing
    '# ListNode represent one item in the linked list
    '# previous and next are used to navigate the
    '# list in both ways
    '# value could contain any kind of pointer
    type ListNode
        previous as ListNode ptr
        value as any ptr
        next as ListNode ptr
    end type

    '# Simple implementation of a Linked List
    '# this mimic the ruby Array class
    '# add will put the new element at last
    '# shift will "pop" the first element
    '# there is also first and last ListNodes so
    '# you could navigate it directly.
    '# we only define a destructor to clear()
    '# the nodes.
    type GenericList
        declare destructor()

        first as ListNode ptr
        last as ListNode ptr

        declare sub add(byval as any ptr)
        declare function shift() as any ptr

        declare property count as ulong

        declare sub clear()

        private:
            _counter as ulong
    end type

end namespace 

#endif 
