# 🐱 Cat-astrophic Security: A Cybersecurity Escape Room

Welcome to **Cat-astrophic Security**, a comprehensive cat-themed cybersecurity escape room featuring challenges across multiple security domains!

## 🎮 Game Overview

The local cat cafe's security system has been hacked by the infamous hacker group "The Scratching Post". You must solve a series of cybersecurity challenges across five different categories to rescue Mittens and save the cats!

### 🆕 Play in 3D!
Experience the challenges in an **immersive 3D first-person escape room**! Navigate through a virtual cat cafe, interact with challenge terminals, and solve puzzles in a fully 3D environment. See [3D_ESCAPE_ROOM_README.md](3D_ESCAPE_ROOM_README.md) for details.

## 📚 Challenge Categories

### ✅ 🔍 **Forensics** (5 Challenges - Terminal Based)
- **Challenge 1**: Log Analysis - Find suspicious actors in security logs
- **Challenge 2**: Metadata Analysis - Discover hidden messages
- **Challenge 3**: Binary Analysis - Extract passwords from corrupted files
- **Challenge 4**: Base64 Decoding - Decode multi-layered messages
- **Challenge 5**: Network Traffic - Identify data exfiltration

### ✅ 🌐 **Web Security** (4 Challenges - Browser Based)
- **Challenge 1**: SQL Injection - Bypass login authentication
- **Challenge 2**: Cross-Site Scripting (XSS) - Inject malicious scripts
- **Challenge 3**: Directory Traversal - Access forbidden files
- **Challenge 4**: Authentication Bypass - Break weak cookie-based auth

### ✅ 💣 **Binary Exploitation** (5 Challenges - Compiled C Programs)
- **Challenge 1**: Buffer Overflow - Overwrite stack variables
- **Challenge 2**: Format String - Leak memory via printf
- **Challenge 3**: Shellcode Execution - Return-to-function
- **Challenge 4**: Return-to-Win (ret2win) - Redirect execution flow
- **Challenge 5**: Use-After-Free - Exploit freed memory

### ✅ 🔐 **Cryptography** (5 Challenges - Python Based)
- **Challenge 1**: Caesar Cipher - Break substitution cipher
- **Challenge 2**: Hash Cracking - Dictionary attack on MD5
- **Challenge 3**: XOR Cipher - Known plaintext attack
- **Challenge 4**: Weak RSA - Factor small primes
- **Challenge 5**: Multi-Layer Encoding - Decode nested Base64

### ✅ ⚙️ **Reverse Engineering** (3 Challenges - Binary Analysis)
- **Challenge 1**: Simple Keygen - Reverse key validation algorithm
- **Challenge 2**: Password Checker - Find hardcoded credentials
- **Challenge 3**: Virtual Machine - Reverse engineer custom VM

## 🚀 Getting Started

```bash
# Start the main game launcher
./escape_room.sh
```

### Prerequisites

**Core Requirements:**
- Bash shell
- Python 3
- Standard Unix tools (cat, grep, strings, etc.)

**For Web Challenges:**
```bash
cd web_app
npm install
```

**For Binary/Reverse Challenges:**
```bash
# Install GCC with 32-bit support
sudo apt-get install gcc gcc-multilib  # Ubuntu/Debian
# or
sudo dnf install gcc glibc-devel.i686  # Fedora/RHEL
```

## 🏗️ Project Structure

```
cat-astrophic-security/
├── escape_room.sh              # Main game launcher
├── scripts/
│   └── game_engine.sh         # Core game functions
├── challenges/
│   ├── forensics/             # 5 shell script challenges ✅
│   ├── web/                   # Web security + vulnerable app ✅
│   ├── binary/                # 5 C programs + Makefile ✅
│   ├── crypto/                # 5 Python challenges ✅
│   └── reverse/               # 3 C programs + Makefile ✅
└── web_app/                   # Vulnerable Node.js web application ✅
```

## 🎯 Challenge Details

### Forensics (Terminal)
Pure terminal-based challenges using standard Unix tools. Learn log analysis, file examination, encoding/decoding, and network traffic analysis.

**Skills:** grep, awk, strings, base64, file, xxd, pattern recognition

### Web Security (Browser + Terminal)
Run a local vulnerable web server and exploit common web vulnerabilities.

**Skills:** SQL injection, XSS, path traversal, cookie manipulation

**Start server:**
```bash
cd web_app
npm start
# Then access http://localhost:3000
```

### Binary Exploitation (Compiled Programs)
Compile and exploit vulnerable C programs with various memory corruption bugs.

**Skills:** Buffer overflows, format strings, stack manipulation, shellcode

**Build:**
```bash
cd challenges/binary
make
./challenge1  # Run individual challenges
```

### Cryptography (Python Interactive)
Break weak cryptographic implementations using various attack techniques.

**Skills:** Cipher breaking, hash cracking, XOR attacks, RSA factorization

**Run:**
```bash
python3 challenges/crypto/challenge1_caesar.py
```

### Reverse Engineering (Binary Analysis)
Analyze compiled binaries to find passwords, understand algorithms, and reverse VM implementations.

**Skills:** Disassembly, decompilation, algorithm analysis, VM reversing

**Tools:** strings, objdump, GDB, Ghidra (optional)

**Build:**
```bash
cd challenges/reverse
make
./challenge1  # Run individual challenges
```

## 🛠️ Useful Tools

### Forensics
- `cat`, `grep`, `awk`, `sort`, `uniq` - Text processing
- `strings` - Extract readable text from binaries
- `base64` - Encode/decode Base64
- `xxd`, `hexdump` - Hex viewers
- `file` - Identify file types

### Web Security
- Browser DevTools (F12)
- Burp Suite (optional)
- cURL for API testing

### Binary Exploitation
- GDB - Debugger
- `objdump` - Disassembler
- Python with pwntools (optional)
- `checksec` - Check binary protections

### Cryptography
- Python 3 with hashlib
- Online hash databases (for learning)

### Reverse Engineering
- `strings` - Find readable text
- `objdump -d` - Disassemble
- Ghidra - Free NSA decompiler
- IDA Free - Alternative decompiler
- radare2 - Open source reverse engineering

## 📖 Documentation

- **[QUICKSTART.md](QUICKSTART.md)** - Get started in 30 seconds
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Add your own challenges

## 🎓 Learning Path

**Beginner:**
1. Start with Forensics challenges
2. Try Cryptography (Caesar, Hash Cracking)
3. Attempt Web Security basics (SQL Injection)

**Intermediate:**
4. Web Security (XSS, Path Traversal)
5. Binary Exploitation (Buffer Overflow)
6. Reverse Engineering (Simple Keygen)

**Advanced:**
7. Binary Exploitation (Format String, Ret2win)
8. Cryptography (RSA, XOR)
9. Reverse Engineering (VM Analysis)

## ⚠️ Security Warning

**This project contains intentionally vulnerable code for educational purposes!**

- **DO NOT** deploy the web application to public servers
- **DO NOT** use any of these patterns in production code
- **DO NOT** run on systems with sensitive data
- Use in isolated, controlled environments only

This is a learning tool for understanding security vulnerabilities.

## 🎉 Features

- ✅ **25+ Challenges** across 5 security domains
- ✅ **Full Color Terminal UI** with ASCII cat art
- ✅ **Progress Tracking** with save states
- ✅ **Built-in Hint System** for all challenges
- ✅ **Code Fragment Collection** mechanic
- ✅ **Educational Content** teaching real security concepts
- ✅ **Clean, Modular Code** easy to understand and extend
- ✅ **Multiple Difficulty Levels** from beginner to advanced

## 🤝 Contributing

Want to add more challenges? Check out [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on creating new challenges in any category!

## 📝 License

MIT License - Educational purposes only

## 🐾 Credits

Created with ❤️ for the cybersecurity learning community

Special thanks to all the cats that inspired this project! 🐱

---

**Ready to save the cat cafe? Run `./escape_room.sh` and let the hacking begin!** 🎯
