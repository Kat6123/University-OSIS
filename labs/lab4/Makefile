.PHONY: test

SRC=main.cpp parse.cpp algoritm.cpp
TEST=test1 test2
EXE=reverse

CFlags=-c -Wall -g -Iinc
LDFlags=
ObjectDir=obj/
SourceDir=src/
BinDir=bin/
TestDir=test/

TEMP=$(TestDir)current

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
	$(CC) $(LDFlags) $(COBJ) -o $@

# Translation, stems are the same, $< - first prerequisite, $@ - target name
$(ObjectDir)%.o: $(SourceDir)%.cpp
	$(CC) $(CFlags) $< -o $@

# Remove all objects and bins
clean:
	$(RM) $(COBJ) $(CEXE)

test:
	for test in $(CTEST); do \
		$(CEXE) -f $$test.in -o $(TEMP); \
		diff $$test.out $(TEMP); \
		$(RM) $(TEMP); \
	done
