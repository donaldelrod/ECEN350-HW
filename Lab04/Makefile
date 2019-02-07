# LAB04 Example Makefile
#
# This makefile is intended for use with GNU make
# This example is intended to be built with Linaro bare-metal GCC

TARGET=Lab04.axf

CC=aarch64-elf-gcc
LD=aarch64-elf-gcc

# Select build rules based on Windows or Unix
ifdef WINDIR
DONE=@if exist $(1) echo Build completed.
RM=if exist $(1) del /q $(1)
SHELL=$(WINDIR)\system32\cmd.exe
else
ifdef windir
DONE=@if exist $(1) echo Build completed.
RM=if exist $(1) del /q $(1)
SHELL=$(windir)\system32\cmd.exe
else
DONE=@if [ -f $(1) ]; then echo Build completed.; fi
RM=rm -f $(1)
endif
endif

all: $(TARGET)
	$(call DONE,$(TARGET))

rebuild: clean all

clean:
	$(call RM,*.o)
	$(call RM,$(TARGET))

main.o: main.c
# Compile for best debug view (lowest optimization)
	$(CC) -c -march=armv8-a -g -O0 $^ -o $@

my_mul.o: my_mul.S
# Compile for best debug view (lowest optimization)
	$(CC) -c -march=armv8-a -g -O0 $^ -o $@
	
lab04b.o: lab04b.S
# Compile for best debug view (lowest optimization)
	$(CC) -c -march=armv8-a -g -O0 $^ -o $@

$(TARGET): main.o my_mul.o lab04b.o
# Link with specific base address to suit VE model memory layout
	$(LD) --specs=aem-ve.specs -Wl,--build-id=none main.o my_mul.o lab04b.o -o $@
