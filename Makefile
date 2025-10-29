# RV64GC
#TARGET	?=riscv64
#ARCH	?=rv64gc
#ABI	?=lp64

#RV32GC
TARGET	?=riscv32
ARCH	?=rv32gc
ABI	?=ilp32d

#CH32V003 - RV32E 
#TARGET	?=riscv32
#ARCH	?=rv32ec_zicsr
#ABI	?=ilp32e

CC	:= clang
LD	:= ld.lld
CFLAGS	:= --target=$(TARGET) -march=$(ARCH) -mabi=$(ABI)
LDFLAGS	:=

SRCS	:= hash.s
OBJS	:= $(SRCS:.s=.o)
EXES	:= hash-tests.x
LIB	:= librvhash.a
RVINT	:= ../rvint/src/librvint.a

HASH_TESTS_OBJS	:= hash-tests.o hash.o

.PHONY:	all clean

all: $(EXES) $(LIB)

%.o: %.s
	$(CC) $(CFLAGS) -c $< -o $@

hash.o: hash.s config.s

hash-tests.x: hash-tests.o $(LIB) $(RVINT)
	$(LD) $(LDFLAGS) $^ $(RVINT) -o $@

$(LIB): $(OBJS)
	$(AR) $(ARFLAGS) $(LIB) $(OBJS)

clean:
	rm -f $(OBJS) $(EXES) $(LIB)
