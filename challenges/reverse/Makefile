# Makefile for Cat-astrophic Security Reverse Engineering Challenges

CC = gcc
ARCH_CHECK = $(shell uname -m)
OS_CHECK = $(shell uname -s)

# Detect architecture and OS to set appropriate flags
ifeq ($(OS_CHECK),Darwin)
    # macOS (both Intel and Apple Silicon)
    CFLAGS = -O0 -g
else
    # Linux - compile 32-bit
    CFLAGS = -m32 -O0 -g -no-pie
endif

STRIP_FLAGS = -s

.PHONY: all clean stripped

all: check-arch challenge1 challenge2 challenge3

check-arch:
	@echo "Building reverse engineering challenges..."
	@echo "Detected: $(OS_CHECK) on $(ARCH_CHECK)"
	@if [ "$(OS_CHECK)" = "Darwin" ] && [ "$(ARCH_CHECK)" = "arm64" ]; then \
		echo "Note: Apple Silicon detected - building native ARM64 binaries"; \
	elif [ "$(OS_CHECK)" = "Linux" ]; then \
		echo "Note: Building 32-bit binaries on Linux"; \
	fi
	@echo ""

stripped: challenge1_stripped challenge2_stripped challenge3_stripped

challenge1: challenge1_simple_keygen.c
	@echo "Compiling Challenge 1: Simple Keygen..."
	$(CC) $(CFLAGS) -o challenge1 challenge1_simple_keygen.c
	@echo "✓ Challenge 1 compiled"

challenge2: challenge2_password_check.c
	@echo "Compiling Challenge 2: Password Checker..."
	$(CC) $(CFLAGS) -o challenge2 challenge2_password_check.c
	@echo "✓ Challenge 2 compiled"

challenge3: challenge3_vm.c
	@echo "Compiling Challenge 3: Virtual Machine..."
	$(CC) $(CFLAGS) -o challenge3 challenge3_vm.c
	@echo "✓ Challenge 3 compiled"

# Stripped versions (harder to reverse)
challenge1_stripped: challenge1
	@echo "Creating stripped version of Challenge 1..."
	cp challenge1 challenge1_stripped
	strip $(STRIP_FLAGS) challenge1_stripped
	@echo "✓ Challenge 1 stripped"

challenge2_stripped: challenge2
	@echo "Creating stripped version of Challenge 2..."
	cp challenge2 challenge2_stripped
	strip $(STRIP_FLAGS) challenge2_stripped
	@echo "✓ Challenge 2 stripped"

challenge3_stripped: challenge3
	@echo "Creating stripped version of Challenge 3..."
	cp challenge3 challenge3_stripped
	strip $(STRIP_FLAGS) challenge3_stripped
	@echo "✓ Challenge 3 stripped"

clean:
	@echo "Cleaning up reverse engineering challenges..."
	rm -f challenge1 challenge2 challenge3
	rm -f challenge1_stripped challenge2_stripped challenge3_stripped
	rm -f *.o
	@echo "✓ Clean complete"

help:
	@echo "Cat-astrophic Security - Reverse Engineering Challenge Builder"
	@echo ""
	@echo "Usage:"
	@echo "  make          - Build all challenges (with symbols)"
	@echo "  make stripped - Build stripped versions (harder)"
	@echo "  make clean    - Remove compiled binaries"
	@echo "  make help     - Show this help"
