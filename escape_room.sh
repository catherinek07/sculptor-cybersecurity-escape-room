#!/bin/bash

# Cat-astrophic Security: Main Game Launcher
# A cat-themed cybersecurity escape room

GAME_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$GAME_DIR/scripts/game_engine.sh"

# Initialize game state
init_game

# Main menu
show_main_menu() {
    show_banner
    show_progress_bar

    echo -e "${CYAN}Welcome to Cat-astrophic Security!${NC}"
    echo ""
    echo -e "The local cat cafe has been hacked by ${RED}The Scratching Post${NC} hacker group!"
    echo -e "Your mission: solve cybersecurity challenges to rescue ${YELLOW}Mittens${NC} and save the cafe!"
    echo ""
    echo -e "${MAGENTA}╔════════════════════════════════════════════════╗${NC}"
    echo -e "${MAGENTA}║${NC}              ${CYAN}CHALLENGE CATEGORIES${NC}              ${MAGENTA}║${NC}"
    echo -e "${MAGENTA}╚════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${GREEN}1)${NC} 🔍 Forensics          ${CYAN}[AVAILABLE]${NC}"
    echo -e "  ${GREEN}2)${NC} 🌐 Web Security       ${YELLOW}[COMING SOON]${NC}"
    echo -e "  ${GREEN}3)${NC} 💣 Binary Exploitation ${YELLOW}[COMING SOON]${NC}"
    echo -e "  ${GREEN}4)${NC} 🔐 Cryptography       ${YELLOW}[COMING SOON]${NC}"
    echo -e "  ${GREEN}5)${NC} ⚙️  Reverse Engineering ${YELLOW}[COMING SOON]${NC}"
    echo ""
    echo -e "  ${GREEN}r)${NC} Reset progress"
    echo -e "  ${GREEN}h)${NC} Help"
    echo -e "  ${GREEN}q)${NC} Quit"
    echo ""
}

# Show help
show_help() {
    clear
    show_banner
    echo -e "${CYAN}╔════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}                    ${YELLOW}HELP${NC}                      ${CYAN}║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${MAGENTA}How to Play:${NC}"
    echo -e "  • Choose a challenge category from the main menu"
    echo -e "  • Complete challenges to collect code fragments"
    echo -e "  • Combine all fragments to get the escape code!"
    echo ""
    echo -e "${MAGENTA}In Each Challenge:${NC}"
    echo -e "  • ${GREEN}submit <answer>${NC} - Submit your answer"
    echo -e "  • ${GREEN}hint${NC} - Get a helpful hint"
    echo -e "  • ${GREEN}help${NC} - Show challenge-specific help"
    echo -e "  • ${GREEN}exit${NC} - Exit current challenge"
    echo ""
    echo -e "${MAGENTA}Useful Tools:${NC}"
    echo -e "  • ${GREEN}cat${NC}, ${GREEN}grep${NC}, ${GREEN}strings${NC} - Read and search files"
    echo -e "  • ${GREEN}base64${NC} - Encode/decode Base64"
    echo -e "  • ${GREEN}xxd${NC}, ${GREEN}hexdump${NC} - View hex dumps"
    echo -e "  • ${GREEN}file${NC} - Identify file types"
    echo ""
    echo -e "${MAGENTA}Tips:${NC}"
    echo -e "  • Read challenge descriptions carefully"
    echo -e "  • Use hints if you're stuck"
    echo -e "  • Experiment with different tools"
    echo -e "  • Think like a cat... I mean, hacker! 🐱"
    echo ""
    echo -e "${YELLOW}Press Enter to return to main menu...${NC}"
    read
}

# Reset progress
reset_progress() {
    echo -e "${YELLOW}Are you sure you want to reset all progress? (y/n)${NC}"
    read -p "> " confirm

    if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
        rm -f "$GAME_DIR/.game_progress"
        rm -f "$GAME_DIR/.current_challenge"
        rm -f "$GAME_DIR/.solved_"*

        # Clean up challenge files
        rm -f "$GAME_DIR/challenges/forensics/security.log"
        rm -f "$GAME_DIR/challenges/forensics/photo_metadata.txt"
        rm -f "$GAME_DIR/challenges/forensics/suspicious.dat"
        rm -f "$GAME_DIR/challenges/forensics/message.txt"
        rm -f "$GAME_DIR/challenges/forensics/network_capture.txt"

        init_game
        echo -e "${GREEN}Progress reset successfully!${NC}"
        echo -e "${YELLOW}Press Enter to continue...${NC}"
        read
    fi
}

# Launch forensics challenges
launch_forensics() {
    local current_challenge=$(get_current_challenge)

    if [ "$current_challenge" = "complete" ]; then
        # Allow replay of challenges
        current_challenge="forensics_1"
    fi

    case "$current_challenge" in
        forensics_1)
            bash "$GAME_DIR/challenges/forensics/challenge1.sh"
            ;;
        forensics_2)
            bash "$GAME_DIR/challenges/forensics/challenge2.sh"
            ;;
        forensics_3)
            bash "$GAME_DIR/challenges/forensics/challenge3.sh"
            ;;
        forensics_4)
            bash "$GAME_DIR/challenges/forensics/challenge4.sh"
            ;;
        forensics_5)
            bash "$GAME_DIR/challenges/forensics/challenge5.sh"
            ;;
        *)
            bash "$GAME_DIR/challenges/forensics/challenge1.sh"
            ;;
    esac
}

# Coming soon message
coming_soon() {
    local category="$1"
    clear
    show_banner
    show_cat
    echo -e "${YELLOW}The $category challenges are coming soon!${NC}"
    echo ""
    echo -e "Stay tuned for more cat-themed security fun! 🐱"
    echo ""
    echo -e "${YELLOW}Press Enter to return to main menu...${NC}"
    read
}

# Main game loop
while true; do
    show_main_menu
    read -p "> " choice

    case "$choice" in
        1)
            launch_forensics
            ;;
        2)
            coming_soon "Web Security"
            ;;
        3)
            coming_soon "Binary Exploitation"
            ;;
        4)
            coming_soon "Cryptography"
            ;;
        5)
            coming_soon "Reverse Engineering"
            ;;
        r|R)
            reset_progress
            ;;
        h|H)
            show_help
            ;;
        q|Q)
            clear
            show_happy_cat
            echo -e "${CYAN}Thanks for playing Cat-astrophic Security!${NC}"
            echo -e "May your paws stay sharp and your code stay secure! 🐾"
            echo ""
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid choice. Please try again.${NC}"
            sleep 1
            ;;
    esac
done
