#!/bin/bash

# Forensics Challenge 2: Steganography in Images (using text-based representation)

source "$(dirname "$0")/../../scripts/game_engine.sh"

CHALLENGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

show_challenge_intro "The Hidden Clue" \
"${CYAN}Great work on the first challenge!${NC} 🎉

The cafe's security footage was recovered, but the files seem corrupted.
We managed to extract some data, but there's something ${YELLOW}hidden${NC} in the files.

Your mission: Find the hidden message in ${GREEN}$CHALLENGE_DIR/photo_metadata.txt${NC}

${MAGENTA}Hint:${NC} Sometimes the most important information is hidden in plain sight.
Try using ${GREEN}strings${NC}, ${GREEN}xxd${NC}, or just carefully reading the file.
Look for anything that seems... out of place! 🔍"

# Create the metadata file with hidden message
create_metadata_file() {
    cat > "$CHALLENGE_DIR/photo_metadata.txt" << 'METAEOF'
PHOTO METADATA DUMP - CAT CAFE SECURITY CAMERA
==============================================

Filename: security_cam_2024_01_05.dat
Camera ID: CAM-003
Location: Play Area - North Corner
Timestamp: 2024-01-05 10:17:03
Resolution: 1920x1080
Format: JPEG
Color Space: RGB
Compression: 85%

EXIF DATA:
----------
Make: SecuriCat Systems
Model: SC-3000
Software: CatWatch v2.4.1
DateTime: 2024:01:05 10:17:03
YCbCrPositioning: Centered

GPS DATA:
---------
Latitude: 37.7749° N
Longitude: 122.4194° W
Altitude: 15.5m

COMMENTS:
---------
cAtNiP_LoVeR: This camera angle is purr-fect!
admin: Scheduled maintenance completed
staff: New feeding schedule posted

FILE INTEGRITY:
---------------
MD5: a3c4e9f2b1d8c7e6f5a4b3c2d1e0f9a8
SHA256: 7f8e9d0c1b2a3f4e5d6c7b8a9e0f1d2c3b4a5e6f7d8c9e0a1b2c3d4e5f6a7b8

ADDITIONAL NOTES:
-----------------
Frame analysis shows no anomalies
Motion detection active
Night vision: Enabled
Audio: Disabled

---END METADATA---
METAEOF
}

create_metadata_file

echo ""
echo -e "${CYAN}Ready to find the hidden message?${NC}"
echo -e "When you've found it, type: ${GREEN}submit <message>${NC}"
echo ""

# Function to check answer
check_answer() {
    local answer=$(echo "$1" | tr '[:upper:]' '[:lower:]' | xargs)
    local correct_answer="catnip_lover"

    if validate_answer "$correct_answer" "$answer"; then
        show_success
        echo -e "${CYAN}Outstanding detective work!${NC}"
        echo -e "The message was hidden in the COMMENTS section with unusual capitalization!"
        echo -e "${YELLOW}cAtNiP_LoVeR${NC} is the hacker's nickname."
        echo ""
        echo -e "Your second code fragment: ${GREEN}W${NC}"
        echo -e "Keep going! You're getting closer to freedom!"
        echo ""

        # Mark challenge as solved
        touch "$CHALLENGE_DIR/../../.solved_forensics_2"
        update_progress
        set_next_challenge "forensics_3"

        echo -e "${YELLOW}Press Enter to continue to the next challenge...${NC}"
        read
        return 0
    else
        show_failure
        echo -e "That's not the hidden message. Look more carefully!"
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
            echo -e "${MAGENTA}Hint:${NC} Look at the COMMENTS section carefully."
            echo -e "One of the usernames has unusual ${YELLOW}cApItAlIzAtIoN${NC}."
            echo -e "Sometimes hackers hide their identity in plain sight!"
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
