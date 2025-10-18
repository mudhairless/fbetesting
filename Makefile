COMPILER = fbc
COMPILE_OPTS = -i inc -g -w all -exx
LINK_OPTS = -lib
TEST_COMPILE_OPTS = -i inc -p lib -g -w all -exx

all: lib/libfbetesting.a lib/libfbetestingmt.a tests

%.o: %.bas 
	$(COMPILER) $(COMPILE_OPTS) -c $< -o $@

%.mt.o: %.bas
	$(COMPILER) $(COMPILE_OPTS) -mt -c $< -o $@

lib/libfbetesting.a: src/Common.o src/GenericList.o src/Helpers.o src/Internals.o src/TestCase.o src/TestSuite.o
	$(COMPILER) $(LINK_OPTS) -x lib/libfbetesting.a src/Common.o src/GenericList.o src/Helpers.o src/Internals.o src/TestCase.o src/TestSuite.o

lib/libfbetestingmt.a: src/Common.mt.o src/GenericList.mt.o src/Helpers.mt.o src/Internals.mt.o src/TestCase.mt.o src/TestSuite.mt.o
	$(COMPILER) $(LINK_OPTS) -x lib/libfbetestingmt.a src/Common.mt.o src/GenericList.mt.o src/Helpers.mt.o src/Internals.mt.o src/TestCase.mt.o src/TestSuite.mt.o

tests:
	$(COMPILER) $(TEST_COMPILE_OPTS) tests/main.bas -x tests/main
	tests/main

clean:
	rm src/*.o lib/*.a 

.PHONY: clean
