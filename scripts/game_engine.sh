#!/bin/bash

# Cat-astrophic Security Game Engine
# Manages game state, challenge progression, and validation

GAME_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROGRESS_FILE="$GAME_DIR/.game_progress"
CHALLENGE_FILE="$GAME_DIR/.current_challenge"

# Color codes for pretty output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Cat ASCII art
show_cat() {
    echo -e "${CYAN}"
    cat << "EOF"
     /\_/\
    ( o.o )
     > ^ <
    /|   |\
   (_|   |_)
EOF
    echo -e "${NC}"
}

show_angry_cat() {
    echo -e "${RED}"
    cat << "EOF"
     /\_/\
    ( -.- )
     > ^ <
    /|   |\
   (_|   |_)
EOF
    echo -e "${NC}"
}

show_happy_cat() {
    echo -e "${GREEN}"
    cat << "EOF"
     /\_/\
    ( ^.^ )
     > ^ <
    /|   |\
   (_|   |_)
EOF
    echo -e "${NC}"
}

# Initialize game state
init_game() {
    if [ ! -f "$PROGRESS_FILE" ]; then
        echo "0" > "$PROGRESS_FILE"
        echo "forensics_1" > "$CHALLENGE_FILE"
    fi
}

# Get current progress
get_progress() {
    if [ -f "$PROGRESS_FILE" ]; then
        cat "$PROGRESS_FILE"
    else
        echo "0"
    fi
}

# Update progress
update_progress() {
    local current=$(get_progress)
    local new_progress=$((current + 1))
    echo "$new_progress" > "$PROGRESS_FILE"
}

# Get current challenge
get_current_challenge() {
    if [ -f "$CHALLENGE_FILE" ]; then
        cat "$CHALLENGE_FILE"
    else
        echo "forensics_1"
    fi
}

# Set next challenge
set_next_challenge() {
    echo "$1" > "$CHALLENGE_FILE"
}

# Validate answer
validate_answer() {
    local expected="$1"
    local user_input="$2"

    if [ "$expected" == "$user_input" ]; then
        return 0
    else
        return 1
    fi
}

# Show banner
show_banner() {
    clear
    echo -e "${MAGENTA}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${MAGENTA}║${NC}  ${CYAN}🐱 CAT-ASTROPHIC SECURITY: CYBERSECURITY ESCAPE ROOM 🐱${NC}  ${MAGENTA}║${NC}"
    echo -e "${MAGENTA}╚════════════════════════════════════════════════════════════╝${NC}"
    show_cat
    echo ""
}

# Show progress bar
show_progress_bar() {
    local progress=$(get_progress)
    local total=5  # Total challenges in current version
    local filled=$((progress * 20 / total))
    local empty=$((20 - filled))

    echo -e "${CYAN}Progress:${NC} ["
    printf "${GREEN}%${filled}s${NC}" | tr ' ' '█'
    printf "${RED}%${empty}s${NC}" | tr ' ' '░'
    echo "] $progress/$total challenges solved"
    echo ""
}

# Display challenge intro
show_challenge_intro() {
    local challenge_name="$1"
    local description="$2"

    echo -e "${YELLOW}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${YELLOW}║${NC}  Challenge: ${CYAN}$challenge_name${NC}"
    echo -e "${YELLOW}╚══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "$description"
    echo ""
}

# Success message
show_success() {
    show_happy_cat
    echo -e "${GREEN}✓ Purr-fect! Challenge solved!${NC}"
    echo ""
}

# Failure message
show_failure() {
    show_angry_cat
    echo -e "${RED}✗ Cat-astrophe! That's not quite right. Try again!${NC}"
    echo ""
}

# Export functions for use in other scripts
export -f show_cat
export -f show_angry_cat
export -f show_happy_cat
export -f show_banner
export -f show_progress_bar
export -f show_challenge_intro
export -f show_success
export -f show_failure
export -f validate_answer
export -f get_progress
export -f update_progress
export -f get_current_challenge
export -f set_next_challenge
