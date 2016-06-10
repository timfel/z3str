default: all

# Change the path to Z3 4.1.1 accordingly
# The directory indicated by this path should contain "lib" and "bin"
# e.g. "/home/z3_src_4.1.1"
Z3_path = /home/tim/Dev/babelsberg-r/dependencies/z3

#-----------------------------------------

JUNK = str
THEORY = strTheory.cpp
MAIN = testMain.cpp
SOURCE = $(THEORY) $(MAIN)
INCLUDE = $(Z3_path)/src/api
LIB = $(Z3_path)/build

shared: $(SOURCE)
	# g++ -c -fPIC -O3 -fopenmp -I$(INCLUDE) -L$(LIB) $(THEORY) -lz3  -o z3str.o
	# g++ -shared -Wl,-soname,libz3str.so -O3 -fopenmp -I$(INCLUDE) -L$(LIB) -lz3 -o libz3str.so z3str.o
	g++ -c -fPIC -O3 -fopenmp -I$(INCLUDE) $(THEORY) -o z3str.o
	g++ -shared -Wl,-soname,libz3str.so -O3 -fopenmp -I$(INCLUDE) -o libz3str.so z3str.o

dynamic: $(SOURCE)
	g++ -O3 -fopenmp -I$(INCLUDE) -L$(LIB) $(SOURCE) -lz3  -o str_dynamc 

all: $(SOURCE)
	g++ -O3 -fopenmp -static -I$(INCLUDE) -L$(LIB) $(SOURCE) -lz3 -lrt -o str -Wall

clean:
	rm -f $(JUNK)
