# Use the intel c++ compiler
CXX=icpc

# Include and lib directories
INCPATH=./
LIBPATH=./

# Staging folders for obj.o files and executables
OBJPATH=./obj
BINPATH=./bin

# Compiler flags
# Use the -mmic flag for native phi binaries
CFLAGS= -Wall 						\
		-openmp 					\
		-vec-report=6 				\
		-ansi-alias 				\
		-O3 						\
		-restrict 					\
		-fp-model fast 				\
		-opt-assume-safe-padding 	\
		-I$(INCPATH)

# Linker flags
LFLAGS= # Nothing... yet 

# Binary name
BIN=cdf

# Create a version of all compiled file names
# with a .o extension
SRCS=$(wildcard *.cpp *.cxx *.c)
OBJS=$(patsubst %.cpp,%.o, 			\
	 $(patsubst %.cxx,%.o, 			\
	 $(patsubst %.c,%.o, $(SRCS))))

# The whole shebang!
all: clear $(BIN)

# Compile C++/C .cpp/.cxx/.c sources into obj.o files
%.o: %.cpp
	mkdir -p $(OBJPATH)
	$(CXX) $(CFLAGS) -c $< -o $(OBJPATH)/$@
%.o: %.cxx
	mkdir -p $(OBJPATH)
	$(CXX) $(CFLAGS) -c $< -o $(OBJPATH)/$@
%.o: %.c
	mkdir -p $(OBJPATH)
	$(CXX) $(CFLAGS) -c $< -o $(OBJPATH)/$@

# Main unit of compilation - generates binary
$(BIN): $(OBJS)
	mkdir -p $(BINPATH)
	$(CXX) $(CFLAGS) -o $(BINPATH)/$(BIN) \
	$(foreach OBJ, $(OBJS), $(OBJPATH)/$(OBJ))

# Make clean - remove obj.o files
clean:
	-rm -f $(OBJPATH)/*.o

# Clear the terminal before compiling
clear:
	-clear
