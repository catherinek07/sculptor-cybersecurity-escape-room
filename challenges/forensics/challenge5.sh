#!/bin/bash

# Forensics Challenge 5: Network Traffic Analysis (simulated)

source "$(dirname "$0")/../../scripts/game_engine.sh"

CHALLENGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

show_challenge_intro "The Final Clue" \
"${CYAN}This is it - the final forensics challenge!${NC} 🎯

We captured network traffic from the hacker's connection.
The data is in ${GREEN}$CHALLENGE_DIR/network_capture.txt${NC}.

Your mission: Analyze the traffic and find the ${YELLOW}port number${NC} the hacker used
to exfiltrate the data!

${MAGENTA}Hint:${NC} Look for suspicious connections, especially those with large data transfers.
The port number will be between 1024 and 65535. Use ${GREEN}grep${NC}, ${GREEN}awk${NC}, or ${GREEN}cut${NC}
to parse the data!"

# Create network capture file
create_capture_file() {
    cat > "$CHALLENGE_DIR/network_capture.txt" << 'CAPEOF'
NETWORK TRAFFIC CAPTURE - CAT CAFE SECURITY
============================================

Timestamp: 2024-01-05 10:17:00 - 10:20:00
Interface: eth0
Capture Filter: all traffic

CONN_ID | TIMESTAMP        | SRC_IP          | SRC_PORT | DST_IP          | DST_PORT | PROTO | SIZE  | FLAGS
--------|------------------|-----------------|----------|-----------------|----------|-------|-------|-------
0001    | 10:17:03.124     | 192.168.1.100   | 54123    | 8.8.8.8         | 53       | UDP   | 64B   | -
0002    | 10:17:03.245     | 192.168.1.100   | 54124    | 192.168.1.1     | 80       | TCP   | 128B  | SYN
0003    | 10:17:04.332     | 192.168.1.105   | 49871    | 192.168.1.100   | 22       | TCP   | 52B   | ACK
0004    | 10:17:05.441     | 192.168.1.100   | 54125    | 192.168.1.1     | 443      | TCP   | 256B  | ACK
0005    | 10:17:08.556     | 192.168.1.100   | 54126    | 1.1.1.1         | 53       | UDP   | 72B   | -
0006    | 10:17:12.667     | 192.168.1.100   | 54127    | 192.168.1.50    | 445      | TCP   | 1024B | ACK
0007    | 10:17:15.778     | 192.168.1.100   | 54128    | 185.199.108.153 | 443      | TCP   | 512B  | ACK
0008    | 10:17:22.889     | 192.168.1.100   | 54129    | 203.0.113.42    | 9999     | TCP   | 15MB  | ACK,PSH
0009    | 10:17:23.991     | 192.168.1.100   | 54130    | 203.0.113.42    | 9999     | TCP   | 12MB  | ACK,PSH
0010    | 10:17:25.102     | 192.168.1.100   | 54131    | 203.0.113.42    | 9999     | TCP   | 18MB  | ACK,PSH,FIN
0011    | 10:17:28.213     | 192.168.1.100   | 54132    | 192.168.1.1     | 80       | TCP   | 256B  | ACK
0012    | 10:17:32.324     | 192.168.1.105   | 49872    | 192.168.1.100   | 22       | TCP   | 48B   | ACK
0013    | 10:17:45.435     | 192.168.1.100   | 54133    | 8.8.8.8         | 53       | UDP   | 68B   | -
0014    | 10:18:01.546     | 192.168.1.100   | 54134    | 192.168.1.1     | 443      | TCP   | 512B  | ACK
0015    | 10:18:15.657     | 192.168.1.100   | 54135    | 192.168.1.50    | 445      | TCP   | 2048B | ACK

SUMMARY:
--------
Total connections: 15
Suspicious: 3 large transfers to 203.0.113.42:9999 (45MB total)
Alert: Port 9999 is commonly used for backdoors and data exfiltration!

NOTES:
------
- Normal web traffic to ports 80/443
- DNS queries to 8.8.8.8 and 1.1.1.1
- Large data transfers detected to external IP
- Recommend blocking port 9999 immediately
CAPEOF
}

create_capture_file

echo ""
echo -e "${CYAN}Ready to analyze the traffic?${NC}"
echo -e "When you've found the suspicious port, type: ${GREEN}submit <port>${NC}"
echo ""

# Function to check answer
check_answer() {
    local answer=$(echo "$1" | xargs)
    local correct_answer="9999"

    if validate_answer "$correct_answer" "$answer"; then
        show_success
        echo -e "${CYAN}🎉 CONGRATULATIONS! 🎉${NC}"
        echo -e "You've identified the exfiltration port: ${YELLOW}9999${NC}"
        echo ""
        echo -e "The hacker used port 9999 to transfer ${RED}45MB${NC} of data!"
        echo -e "This is a common backdoor port used for data exfiltration."
        echo ""
        echo -e "Your final code fragment: ${GREEN}R${NC}"
        echo ""
        echo -e "${MAGENTA}═══════════════════════════════════════════════${NC}"
        echo -e "You've collected all the code fragments!"
        echo -e "Combine them to get the escape code: ${GREEN}MEO-W-ROAR${NC}"
        echo -e "${MAGENTA}═══════════════════════════════════════════════${NC}"
        echo ""
        show_happy_cat
        echo ""
        echo -e "${CYAN}🐱 MITTENS HAS BEEN RESCUED! 🐱${NC}"
        echo ""
        echo -e "Thanks to your amazing forensics skills, you've:"
        echo -e "  ✓ Identified the hacker (mysterious_paws / catnip_lover)"
        echo -e "  ✓ Found the access code (TUNA_FISH_42)"
        echo -e "  ✓ Located Mittens (BASEMENT)"
        echo -e "  ✓ Discovered the exfiltration method (port 9999)"
        echo ""
        echo -e "${YELLOW}You've completed all current forensics challenges!${NC}"
        echo ""
        echo -e "${CYAN}More challenges coming soon:${NC}"
        echo -e "  • Web Security (local web app vulnerabilities)"
        echo -e "  • Binary Exploitation (buffer overflows, ROP)"
        echo -e "  • Cryptography (cipher breaking, hash cracking)"
        echo -e "  • Reverse Engineering (binary analysis)"
        echo ""
        echo -e "${GREEN}Thank you for playing Cat-astrophic Security!${NC}"
        echo ""

        # Mark challenge as solved
        touch "$CHALLENGE_DIR/../../.solved_forensics_5"
        update_progress
        set_next_challenge "complete"

        echo -e "${YELLOW}Press Enter to exit...${NC}"
        read
        return 0
    else
        show_failure
        echo -e "That's not the right port. Look for the unusual traffic!"
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
            echo -e "${MAGENTA}Hint:${NC} Look for connections with unusually ${RED}large data transfers${NC}."
            echo -e "Try: ${GREEN}grep 'MB' network_capture.txt${NC}"
            echo -e "What destination port do all the large transfers use?"
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
