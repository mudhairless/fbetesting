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


#include once "GenericList.bi"

namespace fbe.testing
    '#############################################################
    '# List
    '# dtor()
    destructor GenericList()
        this.clear()
    end destructor

    '# add(byval as any ptr)
    sub GenericList.add(byval value as any ptr)
        dim new_node as ListNode ptr

        new_node = new ListNode

        '# to head of tail?
        if (first = 0) then
            first = new_node
        else
            last->next = new_node
        end if

        '# assign the node values
        with *new_node
            .previous = last
            .value = value
            .next = 0               '# this is the last node!
        end with

        '# increment counter
        _counter += 1

        '# set tail
        last = new_node
    end sub

    '# add(byval as any ptr)
    function GenericList.shift() as any ptr
        dim result as any ptr
        dim new_next as ListNode ptr

        '# empty list?
        if (first = 0) then
            result = 0
        else
            '# get values
            with *first
                result = .value
                new_next = .next
            end with

            '# assign the new first
            delete first
            first = new_next

            '# emtpy nodes? fix the last one then
            if (first = 0) then
                last = 0
            end if

            '# decrement counter
            _counter -= 1
        end if

        return result
    end function

    '# count as ulong
    property GenericList.count as ulong
        return _counter
    end property

    '# clear()
    sub GenericList.clear()
        dim value as any ptr

        value = shift()
        do while not (value = 0)
            value = shift()
        loop
    end sub

end namespace 
