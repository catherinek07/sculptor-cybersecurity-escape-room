#!/bin/bash

# Forensics Challenge 3: Hex Dump Analysis

source "$(dirname "$0")/../../scripts/game_engine.sh"

CHALLENGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

show_challenge_intro "The Corrupted File" \
"${CYAN}You're on a roll!${NC} 🐱‍💻

We found a corrupted file on the system named ${GREEN}suspicious.dat${NC}.
The file extension is wrong, and we can't open it normally.
Something valuable is hidden inside!

Your mission: Find out what the file really is and extract the ${YELLOW}password${NC} hidden inside.

${MAGENTA}Hint:${NC} Use ${GREEN}xxd${NC} or ${GREEN}hexdump${NC} to view the file's raw contents.
Files often have ${YELLOW}magic bytes${NC} at the beginning that identify their type.
You might also try the ${GREEN}file${NC} command, or look for readable text with ${GREEN}strings${NC}!"

# Create a binary file with hidden data
create_binary_file() {
    # Create a fake binary with embedded message
    cat > "$CHALLENGE_DIR/suspicious.dat" << 'BINEOF'
PNG

This is a corrupted PNG file from the cat cafe's security system.
The file signature has been modified to prevent easy analysis.

=== SECURITY BREACH REPORT ===

Date: 2024-01-05
Time: 10:17:03
Incident: Unauthorized access to treat storage
Access Code Used: TUNA_FISH_42

The perpetrator used this access code to open the premium treat cabinet.
All evidence points to an inside job. The treats have been relocated to
a secure location until further notice.

Investigation Status: ONGOING
Priority: HIGH
Assigned to: Agent Whiskers

=== END REPORT ===

Additional notes: Check the scratching post in the corner.
Security footage shows suspicious activity near the catnip stash.

BINEOF
}

create_binary_file

echo ""
echo -e "${CYAN}Ready to analyze the file?${NC}"
echo -e "When you've found the password, type: ${GREEN}submit <password>${NC}"
echo ""

# Function to check answer
check_answer() {
    local answer=$(echo "$1" | tr '[:lower:]' '[:upper:]' | xargs)
    local correct_answer="TUNA_FISH_42"

    if validate_answer "$correct_answer" "$answer"; then
        show_success
        echo -e "${CYAN}Meow-velous! You found it!${NC}"
        echo -e "The access code was: ${YELLOW}TUNA_FISH_42${NC}"
        echo -e "Using ${GREEN}strings${NC} on the file revealed the hidden security report."
        echo ""
        echo -e "Your third code fragment: ${GREEN}-R${NC}"
        echo -e "You're getting close! Two more challenges to go!"
        echo ""

        # Mark challenge as solved
        touch "$CHALLENGE_DIR/../../.solved_forensics_3"
        update_progress
        set_next_challenge "forensics_4"

        echo -e "${YELLOW}Press Enter to continue to the next challenge...${NC}"
        read
        return 0
    else
        show_failure
        echo -e "That's not the right password. Keep analyzing!"
        return 1
    fi
}

# Interactive loop
while true; do
    read -p "> " cmd args

    case "$cmd" in
        submit)
            if check_answer "$args"; then
                break
            fi
            ;;
        hint)
            echo -e "${MAGENTA}Hint:${NC} Try running ${GREEN}strings suspicious.dat${NC} to extract readable text."
            echo -e "Look for anything that looks like an access code or password!"
            echo -e "The format might be something like ${YELLOW}SOMETHING_SOMETHING_##${NC}"
            ;;
        help)
            echo -e "${CYAN}Available commands:${NC}"
            echo -e "  ${GREEN}submit <answer>${NC} - Submit your answer"
            echo -e "  ${GREEN}hint${NC} - Get a hint"
            echo -e "  ${GREEN}help${NC} - Show this help"
            echo -e "  ${GREEN}exit${NC} - Exit the challenge"
            ;;
        exit|quit)
            echo "Exiting challenge..."
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown command.${NC} Type ${GREEN}help${NC} for available commands."
            ;;
    esac
done
