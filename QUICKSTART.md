# 🚀 Quick Start Guide

## Getting Started in 30 Seconds

### Option 1: Terminal-Based Escape Room
```bash
# 1. Make the launcher executable (if not already)
chmod +x escape_room.sh

# 2. Start playing!
./escape_room.sh
```

### Option 2: 🆕 3D Escape Room (Recommended!)
```bash
# 1. Make the launcher executable
chmod +x start_3d_escape_room.sh

# 2. Launch the 3D experience!
./start_3d_escape_room.sh

# 3. Open your browser to http://localhost:3000
# 4. Click "Enter the 3D Escape Room!"
```

The **3D Escape Room** offers an immersive first-person experience where you can walk around and interact with challenge terminals in a virtual cat cafe!

## What You'll Do

1. **Choose "Forensics" (option 1)** - The only available category right now
2. **Solve 5 challenges** by analyzing files, logs, and data
3. **Collect code fragments** from each solved challenge
4. **Rescue Mittens the cat!** 🐱

## Challenge Overview

### 🔍 Forensics Challenges (Available Now!)

1. **The Missing Kitten** - Analyze security logs to find suspicious activity
2. **The Hidden Clue** - Find hidden messages in metadata
3. **The Corrupted File** - Extract data from binary files
4. **The Encoded Message** - Decode Base64-encoded messages
5. **The Final Clue** - Analyze network traffic to find data exfiltration

Each challenge teaches real cybersecurity skills using standard Unix tools!

## Commands in Challenges

```bash
submit <answer>  # Submit your answer
hint            # Get a helpful hint
help            # Show available commands
exit            # Exit the challenge
```

## Useful Unix Tools

You'll use these throughout the challenges:

```bash
cat file.txt              # Read a file
grep "pattern" file.txt   # Search for text
strings binary.dat        # Extract readable text from binary
base64 -d                 # Decode Base64
xxd file.dat              # View hex dump
sort | uniq -c            # Count unique lines
```

## Future Categories (Coming Soon)

- 🌐 **Web Security** - SQL injection, XSS, CSRF
- 💣 **Binary Exploitation** - Buffer overflows, ROP chains
- 🔐 **Cryptography** - Cipher breaking, hash cracking
- ⚙️ **Reverse Engineering** - Binary analysis, keygen creation

## Tips for Success

1. **Read carefully** - Challenge descriptions contain important clues
2. **Use hints** - Don't be afraid to ask for help
3. **Experiment** - Try different tools and approaches
4. **Think creatively** - Sometimes the answer is hiding in plain sight
5. **Have fun!** - This is about learning, not frustration

## Need Help?

- Type `help` in any challenge for command reference
- Use `hint` if you're stuck
- Check the main menu (option `h`) for general help

## Reset Progress

If you want to start over:
- Choose option `r` from the main menu

---

**Ready to save the cat cafe? Let's go!** 🐾
