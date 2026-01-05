# 🛠️ Contributing to Cat-astrophic Security

Want to add more challenges to the escape room? Here's how!

## Project Structure

```
cat-astrophic-security/
├── escape_room.sh              # Main game launcher
├── scripts/
│   └── game_engine.sh         # Core game functions (colors, progress, validation)
├── challenges/
│   ├── forensics/             # Forensics challenges (COMPLETED)
│   ├── web/                   # Web security (TODO)
│   ├── binary/                # Binary exploitation (TODO)
│   ├── crypto/                # Cryptography (TODO)
│   └── reverse/               # Reverse engineering (TODO)
└── web_app/                   # Vulnerable web app (TODO)
```

## Adding New Forensics Challenges

1. Create a new challenge script: `challenges/forensics/challenge6.sh`
2. Follow the existing template structure:
   - Source the game engine
   - Use `show_challenge_intro` for description
   - Create challenge files dynamically
   - Implement answer validation
   - Award a code fragment on success
   - Update progress and set next challenge

3. Update `escape_room.sh` to add your challenge to the progression

## Creating Web Security Challenges

1. Build the web application in `web_app/`:
   - Use Node.js + Express
   - Create intentionally vulnerable endpoints
   - Document each vulnerability

2. Create challenge files in `challenges/web/`:
   - Each challenge should explain the vulnerability
   - Provide hints for exploitation
   - Include solution verification

3. Add web app launcher to `escape_room.sh`

## Adding Binary Exploitation Challenges

1. Write vulnerable C programs in `challenges/binary/`
2. Create a Makefile to compile them
3. Disable security features appropriately:
   - No ASLR: `setarch $(uname -m) -R`
   - No stack canaries: `-fno-stack-protector`
   - Executable stack: `-z execstack`

4. Provide GDB scripts or hints for exploitation

## Creating Cryptography Challenges

1. Use Python scripts in `challenges/crypto/`
2. Focus on common crypto mistakes:
   - Weak key generation
   - Poor randomness
   - Mode of operation vulnerabilities
   - Hash collisions

3. Provide encrypted files or ciphertexts
4. Include Python crypto libraries as needed

## Reverse Engineering Challenges

1. Compile binaries with interesting logic
2. Consider adding:
   - String obfuscation
   - Anti-debugging techniques
   - Custom VMs
   - License key validation

3. Provide hints on tools to use (Ghidra, radare2, etc.)

## Code Style Guidelines

- **Cat puns are encouraged!** 🐱
- Use colored output for better UX
- Always provide hints
- Include educational content
- Test your challenges thoroughly
- Keep solutions achievable for intermediate users

## Testing Your Challenge

```bash
# Test your challenge directly
bash challenges/category/your_challenge.sh

# Test from main launcher
./escape_room.sh
```

## Challenge Design Principles

1. **Educational First** - Teach real security concepts
2. **Progressive Difficulty** - Start easy, get harder
3. **Clear Instructions** - Users should understand the goal
4. **Multiple Hints** - Don't let users get stuck
5. **Positive Feedback** - Celebrate successes!

## Submitting Your Challenge

1. Test your challenge end-to-end
2. Document any new dependencies
3. Update README.md if needed
4. Submit a pull request with:
   - Challenge description
   - Learning objectives
   - Estimated difficulty
   - Any prerequisites

## Challenge Template

```bash
#!/bin/bash

source "$(dirname "$0")/../../scripts/game_engine.sh"
CHALLENGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

show_challenge_intro "Your Challenge Name" \
"Challenge description here..."

# Create challenge files
create_files() {
    # Your code here
}

create_files

# Interactive loop
check_answer() {
    local answer="$1"
    local correct="your_answer"

    if validate_answer "$correct" "$answer"; then
        show_success
        echo "Your success message"
        echo "Code fragment: ${GREEN}XYZ${NC}"

        touch "$CHALLENGE_DIR/../../.solved_your_challenge"
        update_progress
        set_next_challenge "next_challenge"
        return 0
    else
        show_failure
        return 1
    fi
}

while true; do
    read -p "> " cmd args
    case "$cmd" in
        submit) check_answer "$args" && break ;;
        hint) echo "Your hint" ;;
        help) echo "Your help" ;;
        exit|quit) exit 0 ;;
        *) echo "Unknown command" ;;
    esac
done
```

## Questions?

Open an issue or submit a pull request. Let's make cybersecurity education fun! 🎉
