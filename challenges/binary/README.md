# 💣 Binary Exploitation Challenges

Coming Soon! This section will include:

## Planned Challenges

1. **Buffer Overflow** - Overflow a buffer to control program execution
2. **Format String Vulnerability** - Exploit format string bugs to read/write memory
3. **Return-Oriented Programming (ROP)** - Chain gadgets to bypass NX protection
4. **Use-After-Free** - Exploit memory that has been freed
5. **Integer Overflow** - Cause arithmetic errors to bypass security checks

## Requirements

- GCC compiler
- GDB debugger
- Python (for exploit scripts)
- pwntools (optional, for advanced exploits)

## Setup

Compile the vulnerable programs:

```bash
cd challenges/binary
make all
```

## Structure

```
binary/
├── README.md
├── Makefile
├── challenge1_buffer_overflow.c
├── challenge2_format_string.c
├── challenge3_rop.c
├── challenge4_use_after_free.c
└── challenge5_integer_overflow.c
```

## Learning Resources

- Buffer overflows: Understanding stack frames
- NX/DEP: Non-executable stack protection
- ASLR: Address Space Layout Randomization
- PIE: Position Independent Executables

Happy hacking! 🐱‍💻
