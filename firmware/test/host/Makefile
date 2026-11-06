# Testy logiki sterownika na komputerze (bez płytki): make -C test/host
CORE = ../../lib/core/src
test: test_core
	./test_core
test_core: test_core.cpp $(CORE)/*.cpp $(CORE)/*.h
	g++ -std=c++17 -Wall -Wextra -O1 -I$(CORE) -o $@ test_core.cpp $(CORE)/*.cpp
clean:
	rm -f test_core
