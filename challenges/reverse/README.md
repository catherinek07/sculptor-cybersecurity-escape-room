# ⚙️ Reverse Engineering Challenges

Coming Soon! This section will include:

## Planned Challenges

1. **Basic Keygen** - Reverse engineer a license key algorithm
2. **Crack Me** - Find the password in a compiled binary
3. **Anti-Debugging** - Bypass anti-debugging techniques
4. **Obfuscated Code** - Deobfuscate and understand mangled code
5. **VM Reversing** - Reverse engineer a custom virtual machine

## Requirements

- GDB or LLDB debugger
- Ghidra or IDA Pro (free version)
- radare2
- Python (for scripting)
- Hex editor

## Setup

Tools installation:

```bash
# Install Ghidra
# Download from: https://ghidra-sre.org/

# Install radare2
git clone https://github.com/radareorg/radare2
cd radare2
./sys/install.sh
```

## Structure

```
reverse/
├── README.md
├── challenge1_keygen
├── challenge2_crackme
├── challenge3_anti_debug
├── challenge4_obfuscated
└── challenge5_vm
```

## Key Skills

- Reading assembly (x86/x64, ARM)
- Understanding calling conventions
- Using disassemblers and decompilers
- Dynamic analysis with debuggers
- Pattern recognition in binaries

Reverse all the things! 🔧
