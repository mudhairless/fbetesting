@IF "%fbc%"=="" (
    @echo Please run SET FBC=fbc32 or your preferred compiler first
    @goto :eof
)

@echo Clearing Old Build Files
del src\*.o
del lib\*.a
del tests\*.exe
del tests\*.tst
del examples\*.exe

@echo Building Components
%fbc% -c -i inc -w all -exx src/Common.bas
%fbc% -c -i inc -w all -exx src/GenericList.bas
%fbc% -c -i inc -w all -exx src/Helpers.bas
%fbc% -c -i inc -w all -exx src/Internals.bas
%fbc% -c -i inc -w all -exx src/TestCase.bas
%fbc% -c -i inc -w all -exx src/TestSuite.bas

@echo Building Libraries
%fbc% -lib src/Common.o src/GenericList.o src/Helpers.o src/Internals.o src/TestCase.o src/TestSuite.o -x lib/libfbetesting.a

@echo Building MT Components
@del src\*.o
%fbc% -c -i inc -w all -mt -exx src/Common.bas
%fbc% -c -i inc -w all -mt -exx src/GenericList.bas
%fbc% -c -i inc -w all -mt -exx src/Helpers.bas
%fbc% -c -i inc -w all -mt -exx src/Internals.bas
%fbc% -c -i inc -w all -mt -exx src/TestCase.bas
%fbc% -c -i inc -w all -mt -exx src/TestSuite.bas

@echo Building MT Libraries
%fbc% -mt -lib src/Common.o src/GenericList.o src/Helpers.o src/Internals.o src/TestCase.o src/TestSuite.o -x lib/libfbetestingmt.a

@echo Running Tests
%fbc% -p lib -i inc -w all -exx tests/main.bas
tests\main.exe


@echo Building examples
%fbc% -p lib -i inc -w all -exx examples/simple.bas
%fbc% -p lib -i inc -w all -exx examples/adv_main.bas examples/adv_suite_1.bas examples/adv_suite_2.bas -m adv_main -x examples/advanced.exe
