SRC=main.cpp daemon.cpp handler.cpp utils.cpp
EXE=signalHandler

CFlags= -std=c++0x -c -Wall -g -Iinc
LDFlags=-lpthread
ObjectDir=obj/
SourceDir=src/
BinDir=bin/

CC=g++
RM=rm -rf

OBJ=$(SRC:.cpp=.o)
CSRC=$(addprefix $(SourceDir),$(SRC))
COBJ=$(addprefix $(ObjectDir),$(OBJ))
CEXE=$(addprefix $(BinDir),$(EXE))
CTEST=$(addprefix $(TestDir),$(TEST))

all: $(CSRC) $(CEXE)

# Linking
$(CEXE): $(COBJ)
	$(CC) $(COBJ) -o $@ $(LDFlags)

# Translation, stems are the same, $< - first prerequisite, $@ - target name
$(ObjectDir)%.o: $(SourceDir)%.cpp
	$(CC) $(CFlags) $< -o $@

# Remove all objects and bins
clean:
	$(RM) $(COBJ) $(CEXE)
