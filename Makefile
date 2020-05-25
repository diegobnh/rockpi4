#CXXFLAGS += -std=c++14 -O2 -pedantic -Wall -Wextra -Wno-unused-parameter -Wno-unused-variable -Wno-unused-function
CXXFLAGS += -std=c++14 -O2 -pedantic -w

SRC_FILES = src/main.cpp src/perf.cpp

all: build

build:
	mkdir -p bin
	$(CXX) $(CXXFLAGS) $(SRC_FILES) -o bin/scheduler_A53 -DPMC_TYPE=53
	$(CXX) $(CXXFLAGS) $(SRC_FILES) -o bin/scheduler_A72 -DPMC_TYPE=72

clean:
	rm -f ./bin/scheduler*
	rm -f *.csv
