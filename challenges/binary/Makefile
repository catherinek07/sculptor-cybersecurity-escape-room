# Makefile for Cat-astrophic Security Binary Challenges
# Compiles vulnerable binaries for educational purposes

CC = gcc
ARCH_CHECK = $(shell uname -m)
OS_CHECK = $(shell uname -s)

# Detect architecture and OS to set appropriate flags
ifeq ($(OS_CHECK),Darwin)
    # macOS (both Intel and Apple Silicon)
    ifeq ($(ARCH_CHECK),arm64)
        # Apple Silicon - compile for native ARM64
        CFLAGS = -fno-stack-protector -g -Wno-deprecated-declarations
    else
        # Intel Mac
        CFLAGS = -fno-stack-protector -g -Wno-deprecated-declarations
    endif
else
    # Linux - try to compile 32-bit for traditional binary exploitation
    CFLAGS = -m32 -fno-stack-protector -z execstack -no-pie -g
endif

.PHONY: all clean check-arch

all: check-arch challenge1 challenge2 challenge3 challenge4 challenge5

check-arch:
	@echo "Building binaries for security training..."
	@echo "Detected: $(OS_CHECK) on $(ARCH_CHECK)"
	@if [ "$(OS_CHECK)" = "Darwin" ] && [ "$(ARCH_CHECK)" = "arm64" ]; then \
		echo "Note: Apple Silicon detected - building native ARM64 binaries"; \
		echo "Stack protections disabled for educational purposes"; \
	elif [ "$(OS_CHECK)" = "Linux" ] && [ "$(ARCH_CHECK)" = "x86_64" ]; then \
		echo "Note: Building 32-bit binaries on 64-bit Linux"; \
		echo "You may need: sudo apt-get install gcc-multilib"; \
	fi
	@echo ""

challenge1: challenge1_buffer_overflow.c
	@echo "Compiling Challenge 1: Buffer Overflow..."
	$(CC) $(CFLAGS) -o challenge1 challenge1_buffer_overflow.c
	@echo "✓ Challenge 1 compiled"

challenge2: challenge2_format_string.c
	@echo "Compiling Challenge 2: Format String..."
	$(CC) $(CFLAGS) -o challenge2 challenge2_format_string.c
	@echo "✓ Challenge 2 compiled"

challenge3: challenge3_shellcode.c
	@echo "Compiling Challenge 3: Shellcode Execution..."
	$(CC) $(CFLAGS) -o challenge3 challenge3_shellcode.c
	@echo "✓ Challenge 3 compiled"

challenge4: challenge4_ret2win.c
	@echo "Compiling Challenge 4: Return-to-Win..."
	$(CC) $(CFLAGS) -o challenge4 challenge4_ret2win.c
	@echo "✓ Challenge 4 compiled"

challenge5: challenge5_use_after_free.c
	@echo "Compiling Challenge 5: Use-After-Free..."
	$(CC) $(CFLAGS) -o challenge5 challenge5_use_after_free.c
	@echo "✓ Challenge 5 compiled"

clean:
	@echo "Cleaning up compiled binaries..."
	rm -f challenge1 challenge2 challenge3 challenge4 challenge5
	rm -f *.o
	@echo "✓ Clean complete"

help:
	@echo "Cat-astrophic Security - Binary Challenge Builder"
	@echo ""
	@echo "Usage:"
	@echo "  make          - Build all challenges"
	@echo "  make clean    - Remove compiled binaries"
	@echo "  make help     - Show this help"
	@echo ""
	@echo "Individual challenges:"
	@echo "  make challenge1 - Buffer Overflow"
	@echo "  make challenge2 - Format String"
	@echo "  make challenge3 - Shellcode Execution"
	@echo "  make challenge4 - Return-to-Win"
	@echo "  make challenge5 - Use-After-Free"
