#!/bin/bash

# Forensics Challenge 1: Hidden Message in Log Files

source "$(dirname "$0")/../../scripts/game_engine.sh"

CHALLENGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

show_challenge_intro "The Missing Kitten" \
"${CYAN}Agent Whiskers${NC} reporting in! 🐱

One of our kittens, ${YELLOW}Mittens${NC}, has gone missing from the cat cafe.
We found a suspicious log file on the security system. Someone has been
tampering with the camera feeds!

Your mission: Analyze the log file at ${GREEN}$CHALLENGE_DIR/security.log${NC}
and find the ${YELLOW}username${NC} of the suspicious actor.

${MAGENTA}Hint:${NC} Look for unusual patterns or repeated failed access attempts.
Standard Unix tools like ${GREEN}cat${NC}, ${GREEN}grep${NC}, ${GREEN}sort${NC}, ${GREEN}uniq${NC} might help!"

# Create the log file if it doesn't exist
create_log_file() {
    cat > "$CHALLENGE_DIR/security.log" << 'LOGEOF'
2024-01-05 08:15:23 [INFO] Camera_1 - Motion detected - User: cafe_staff
2024-01-05 08:15:45 [INFO] Camera_2 - Motion detected - User: cafe_staff
2024-01-05 09:30:12 [INFO] Camera_1 - Access granted - User: manager_tom
2024-01-05 09:30:45 [INFO] Door_Main - Opened - User: manager_tom
2024-01-05 10:15:33 [WARN] Camera_3 - Access denied - User: mysterious_paws
2024-01-05 10:15:47 [WARN] Camera_3 - Access denied - User: mysterious_paws
2024-01-05 10:16:02 [WARN] Camera_4 - Access denied - User: mysterious_paws
2024-01-05 10:16:15 [WARN] Door_Back - Access denied - User: mysterious_paws
2024-01-05 10:16:28 [WARN] Camera_5 - Access denied - User: mysterious_paws
2024-01-05 10:17:03 [ERROR] Camera_3 - Feed interrupted - User: mysterious_paws
2024-01-05 10:17:45 [ERROR] Camera_4 - Feed interrupted - User: mysterious_paws
2024-01-05 10:18:22 [CRITICAL] System - Multiple cameras offline
2024-01-05 11:30:15 [INFO] Camera_1 - Motion detected - User: customer_alice
2024-01-05 11:45:22 [INFO] Camera_2 - Motion detected - User: customer_bob
2024-01-05 12:00:33 [INFO] Camera_1 - Access granted - User: cafe_staff
2024-01-05 13:15:44 [INFO] Door_Main - Opened - User: delivery_service
2024-01-05 13:16:12 [INFO] Door_Main - Closed - User: delivery_service
2024-01-05 14:30:25 [INFO] Camera_2 - Motion detected - User: customer_charlie
2024-01-05 15:45:11 [INFO] System - All cameras online
2024-01-05 16:22:08 [INFO] Camera_5 - Motion detected - User: cafe_staff
LOGEOF
}

# Create the log file
create_log_file

echo ""
echo -e "${CYAN}Ready to solve the challenge?${NC}"
echo -e "When you've found the suspicious username, type: ${GREEN}submit <username>${NC}"
echo ""

# Function to check answer
check_answer() {
    local answer=$(echo "$1" | tr '[:upper:]' '[:lower:]' | xargs)
    local correct_answer="mysterious_paws"

    if validate_answer "$correct_answer" "$answer"; then
        show_success
        echo -e "${CYAN}Excellent work, detective!${NC}"
        echo -e "You've identified the hacker: ${YELLOW}mysterious_paws${NC}"
        echo -e "They attempted multiple unauthorized access attempts before"
        echo -e "successfully interrupting the camera feeds!"
        echo ""
        echo -e "Your first code fragment: ${GREEN}MEO${NC}"
        echo -e "Keep collecting fragments to unlock the final escape code!"
        echo ""

        # Mark challenge as solved
        touch "$CHALLENGE_DIR/../../.solved_forensics_1"
        update_progress
        set_next_challenge "forensics_2"

        echo -e "${YELLOW}Press Enter to continue to the next challenge...${NC}"
        read
        return 0
    else
        show_failure
        echo -e "That's not the right username. Keep investigating!"
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
            echo -e "${MAGENTA}Hint:${NC} Try counting how many times each user appears in the logs."
            echo -e "The command ${GREEN}grep 'User:' security.log | cut -d':' -f4 | sort | uniq -c${NC}"
            echo -e "might help you spot patterns!"
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
