#!/bin/bash

# Forensics Challenge 4: Base64 Encoding and Obfuscation

source "$(dirname "$0")/../../scripts/game_engine.sh"

CHALLENGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

show_challenge_intro "The Encoded Message" \
"${CYAN}Almost there, detective!${NC} 🕵️‍♀️

The hacker left behind an encoded message in ${GREEN}$CHALLENGE_DIR/message.txt${NC}.
It appears to be using some kind of encoding to hide their tracks.

Your mission: Decode the message and find the ${YELLOW}location${NC} where Mittens is being held!

${MAGENTA}Hint:${NC} The message looks like random characters, but it might be ${YELLOW}Base64${NC} encoded.
Try using ${GREEN}base64 -d${NC} to decode it. You might need to decode multiple times!"

# Create the encoded message file
create_encoded_file() {
    # Message: "Mittens is hidden in the BASEMENT behind the scratching post"
    # We'll encode it in base64 twice for extra challenge
    local original="Mittens is hidden in the BASEMENT behind the scratching post"
    local encoded_once=$(echo "$original" | base64)
    local encoded_twice=$(echo "$encoded_once" | base64)

    cat > "$CHALLENGE_DIR/message.txt" << MSGEOF
===== INTERCEPTED MESSAGE =====

From: mysterious_paws
To: catnip_lover
Subject: Package Location

TFdsMGRHVnVjeUJwY3lCb2FXUmtaVzRnYVc0Z2RHaGxJRUpCVTBWTlJVNVVJR0psYUdsdVpDQjBhR1VnYzJOeVlYUmphR2x1WnlCd2IzTjAK

Important: Remember to feed the cats!

- M.P.

===== END MESSAGE =====
MSGEOF
}

create_encoded_file

echo ""
echo -e "${CYAN}Ready to decode the message?${NC}"
echo -e "When you've found the location, type: ${GREEN}submit <location>${NC}"
echo ""

# Function to check answer
check_answer() {
    local answer=$(echo "$1" | tr '[:lower:]' '[:upper:]' | xargs)
    local correct_answer="BASEMENT"

    if validate_answer "$correct_answer" "$answer"; then
        show_success
        echo -e "${CYAN}Paw-some decoding skills!${NC}"
        echo -e "You decoded the message correctly!"
        echo -e "${YELLOW}Mittens is in the BASEMENT!${NC}"
        echo ""
        echo -e "The message was Base64 encoded ${MAGENTA}twice${NC} to make it harder to read."
        echo -e "You can decode it with: ${GREEN}base64 -d | base64 -d${NC}"
        echo ""
        echo -e "Your fourth code fragment: ${GREEN}OA${NC}"
        echo -e "One more challenge left! You can do it!"
        echo ""

        # Mark challenge as solved
        touch "$CHALLENGE_DIR/../../.solved_forensics_4"
        update_progress
        set_next_challenge "forensics_5"

        echo -e "${YELLOW}Press Enter to continue to the final challenge...${NC}"
        read
        return 0
    else
        show_failure
        echo -e "That's not the right location. Try decoding again!"
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
            echo -e "${MAGENTA}Hint:${NC} Extract the encoded text from the message file."
            echo -e "Try: ${GREEN}grep -v '=' message.txt | grep -v '^$' | tail -3 | head -1${NC}"
            echo -e "Then decode with: ${GREEN}echo 'ENCODED_TEXT' | base64 -d${NC}"
            echo -e "If you get more base64, decode again! Think of it like unwrapping layers."
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
