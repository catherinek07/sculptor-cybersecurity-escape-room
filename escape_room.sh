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
    echo -e "  ${GREEN}2)${NC} 🌐 Web Security       ${CYAN}[AVAILABLE]${NC}"
    echo -e "  ${GREEN}3)${NC} 💣 Binary Exploitation ${CYAN}[AVAILABLE]${NC}"
    echo -e "  ${GREEN}4)${NC} 🔐 Cryptography       ${CYAN}[AVAILABLE]${NC}"
    echo -e "  ${GREEN}5)${NC} ⚙️  Reverse Engineering ${CYAN}[AVAILABLE]${NC}"
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

# Launch web security challenges
launch_web() {
    bash "$GAME_DIR/challenges/web/web_challenges.sh"
}

# Launch binary exploitation challenges
launch_binary() {
    clear
    show_banner
    echo -e "${CYAN}Binary Exploitation Challenges${NC}"
    echo ""
    echo -e "These challenges require compiling C programs."
    echo -e "First, let's build the challenges..."
    echo ""
    echo -e "${YELLOW}Press Enter to continue...${NC}"
    read

    cd "$GAME_DIR/challenges/binary"

    if ! command -v gcc &> /dev/null; then
        echo -e "${RED}Error: GCC is not installed!${NC}"
        echo -e "Please install: ${GREEN}sudo apt-get install gcc gcc-multilib${NC}"
        echo ""
        echo -e "${YELLOW}Press Enter to return...${NC}"
        read
        return
    fi

    if [ ! -f "challenge1" ]; then
        echo -e "${CYAN}Building challenges...${NC}"
        make
        echo ""
    fi

    echo -e "${GREEN}Challenges built successfully!${NC}"
    echo ""
    echo -e "Available challenges:"
    echo -e "  ${GREEN}1)${NC} Buffer Overflow - ./challenge1"
    echo -e "  ${GREEN}2)${NC} Format String - ./challenge2"
    echo -e "  ${GREEN}3)${NC} Shellcode Execution - ./challenge3"
    echo -e "  ${GREEN}4)${NC} Return-to-Win - ./challenge4"
    echo -e "  ${GREEN}5)${NC} Use-After-Free - ./challenge5"
    echo ""
    echo -e "Run them directly from: ${CYAN}challenges/binary/${NC}"
    echo ""
    echo -e "${YELLOW}Press Enter to return to main menu...${NC}"
    read
}

# Launch cryptography challenges
launch_crypto() {
    clear
    show_banner
    echo -e "${CYAN}Cryptography Challenges${NC}"
    echo ""
    echo -e "Choose a challenge:"
    echo -e "  ${GREEN}1)${NC} Caesar Cipher"
    echo -e "  ${GREEN}2)${NC} Hash Cracking"
    echo -e "  ${GREEN}3)${NC} XOR Cipher"
    echo -e "  ${GREEN}4)${NC} Weak RSA"
    echo -e "  ${GREEN}5)${NC} Multi-Layer Base64"
    echo -e "  ${GREEN}b)${NC} Back to main menu"
    echo ""
    read -p "> " choice

    case "$choice" in
        1) python3 "$GAME_DIR/challenges/crypto/challenge1_caesar.py" ;;
        2) python3 "$GAME_DIR/challenges/crypto/challenge2_hash_crack.py" ;;
        3) python3 "$GAME_DIR/challenges/crypto/challenge3_xor.py" ;;
        4) python3 "$GAME_DIR/challenges/crypto/challenge4_weak_rsa.py" ;;
        5) python3 "$GAME_DIR/challenges/crypto/challenge5_base64_layers.py" ;;
        b|B) return ;;
        *) echo -e "${RED}Invalid choice${NC}"; sleep 1; launch_crypto ;;
    esac
}

# Launch reverse engineering challenges
launch_reverse() {
    clear
    show_banner
    echo -e "${CYAN}Reverse Engineering Challenges${NC}"
    echo ""
    echo -e "These challenges require analyzing compiled binaries."
    echo -e "First, let's build them..."
    echo ""
    echo -e "${YELLOW}Press Enter to continue...${NC}"
    read

    cd "$GAME_DIR/challenges/reverse"

    if ! command -v gcc &> /dev/null; then
        echo -e "${RED}Error: GCC is not installed!${NC}"
        echo -e "Please install: ${GREEN}sudo apt-get install gcc gcc-multilib${NC}"
        echo ""
        echo -e "${YELLOW}Press Enter to return...${NC}"
        read
        return
    fi

    if [ ! -f "challenge1" ]; then
        echo -e "${CYAN}Building challenges...${NC}"
        make
        echo ""
    fi

    echo -e "${GREEN}Challenges built successfully!${NC}"
    echo ""
    echo -e "Available challenges:"
    echo -e "  ${GREEN}1)${NC} Simple Keygen - ./challenge1"
    echo -e "  ${GREEN}2)${NC} Password Checker - ./challenge2"
    echo -e "  ${GREEN}3)${NC} Virtual Machine - ./challenge3"
    echo ""
    echo -e "Useful tools:"
    echo -e "  • strings - Extract readable text"
    echo -e "  • objdump -d - Disassemble"
    echo -e "  • Ghidra - Full decompiler (download separately)"
    echo ""
    echo -e "Run them directly from: ${CYAN}challenges/reverse/${NC}"
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
            launch_web
            ;;
        3)
            launch_binary
            ;;
        4)
            launch_crypto
            ;;
        5)
            launch_reverse
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
