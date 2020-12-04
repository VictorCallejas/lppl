# Directorios de trabajo
SRC_DIR = src
INC = include
#BUILD_DIR = build
TEST_DIR = tmp
#OUT_DIR = releases

OUTNAME = cmc

# Opciones de compilacion
COPT = -Wall
CLIB = -lfl

COMPILE_OBJS = clean flex_obj bison_obj principal_obj asin.o alex.o

SUP_FILES = asin.o alex.o

OBJ_FILES = principal.o
#TEST_FILES = $(TEST_DIR)/a00 $(TEST_DIR)/a01 $(TEST_DIR)/a02 $(TEST_DIR)/a03 $(TEST_DIR)/a04
TEST_OBJS = test0 test1 test2 test3 test4

build: $(COMPILE_OBJS)
	gcc  $(SUP_FILES) $(OBJ_FILES) -I$(INC)  $(COPT)  $(CLIB) -o$(OUTNAME)
	$(info *** BUILD SUCCED ***)

bison_obj:	$(SRC_DIR)/asin.y
	bison -oasin.c  -d $(SRC_DIR)/asin.y
	mv asin.h include
	$(info *** BISON COMPILED ***)
		
flex_obj: $(SRC_DIR)/alex.l 
	flex -oalex.c $(SRC_DIR)/alex.l
	$(info *** FLEX COMPILED ***)

principal_obj:$(SRC_DIR)/principal.c
	gcc  -I$(INC) $(COPT) -c $(SRC_DIR)/principal.c -oprincipal.o

asin.o:	asin.c
	gcc  -I$(INC) $(COPT) -c asin.c -oasin.o
alex.o:	alex.c asin.c
	gcc  -I$(INC) $(COPT) -c alex.c -oalex.o

clean:
	rm -f build/*
	$(info *** CLEANED ***)

test: $(COMPILE_OBJS) $(TEST_OBJS)
	$(info *** TESTS SUCCED ***)
test0:
	$(info *** TESTING 0 ***)
	gcc  -I$(INC) $(SUP_FILES) $(TEST_DIR)/a00.c   $(COPT)  $(CLIB) -o $(OUT_DIR)/a00 
#	$(info *** TEST 0 SUCCED ***)
test1:	
	$(info *** TESTING 1 ***)
	gcc  $(SUP_FILES) $(TEST_DIR)/a01.c -I$(INC)  $(COPT)  $(CLIB) -o $(OUT_DIR)/a01 
#	$(info *** TEST 1 SUCCED ***)
test2:
	$(info *** TESTING 2 ***)
	gcc  $(SUP_FILES) $(TEST_DIR)/a02.c -I$(INC)  $(COPT)  $(CLIB) -o $(OUT_DIR)/a02 
#	$(info *** TEST 2 SUCCED ***)
test3:
	$(info *** TESTING 3 ***)
	gcc  $(SUP_FILES) $(TEST_DIR)/a03.c -I$(INC)  $(COPT)  $(CLIB) -o $(OUT_DIR)/a03
#	$(info *** TEST 3 SUCCED ***)
test4:
	$(info *** TESTING 4 ***)
	gcc  $(SUP_FILES) $(TEST_DIR)/a04.c -I$(INC)  $(COPT)  $(CLIB) -o $(OUT_DIR)/a04
#	$(info *** TEST 4 SUCCED ***)



