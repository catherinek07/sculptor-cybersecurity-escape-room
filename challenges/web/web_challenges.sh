#!/bin/bash

# Web Security Challenges Launcher

source "$(dirname "$0")/../../scripts/game_engine.sh"

CHALLENGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

show_challenge_intro "Web Security Challenges" \
"${CYAN}Welcome to the Web Security section!${NC} 🌐

The Cat Cafe has a web application with multiple security vulnerabilities.
Your mission: Find and exploit these vulnerabilities to complete the challenges!

${YELLOW}Available Challenges:${NC}
1. ${GREEN}SQL Injection${NC} - Bypass login authentication
2. ${GREEN}Cross-Site Scripting (XSS)${NC} - Inject malicious scripts
3. ${GREEN}Directory Traversal${NC} - Access forbidden files
4. ${GREEN}Authentication Bypass${NC} - Access the admin panel

${MAGENTA}Getting Started:${NC}
1. Start the web server: ${GREEN}bash challenges/web/start_server.sh${NC}
2. Open your browser to: ${GREEN}http://localhost:3000${NC}
3. Complete the challenges and find the flags!
4. Return here to verify your progress

${RED}Note:${NC} The web server must be running in a separate terminal!"

echo ""
echo -e "${CYAN}Commands:${NC}"
echo -e "  ${GREEN}verify <challenge>${NC} - Verify a completed challenge"
echo -e "  ${GREEN}hint <challenge>${NC} - Get a hint for a challenge"
echo -e "  ${GREEN}list${NC} - List all challenges"
echo -e "  ${GREEN}help${NC} - Show this help"
echo -e "  ${GREEN}exit${NC} - Exit"
echo ""

# Challenge tracking
declare -A completed_challenges

# Show challenges list
show_challenges() {
    echo -e "${YELLOW}Web Security Challenges:${NC}"
    echo ""
    echo -e "1. ${GREEN}sql_injection${NC} - Bypass login as admin"
    echo -e "   Flag format: FLAG{4dm1n_4cc3ss_gr4nt3d}"
    echo ""
    echo -e "2. ${GREEN}xss${NC} - Execute JavaScript in comments"
    echo -e "   Goal: Successfully inject and execute XSS"
    echo ""
    echo -e "3. ${GREEN}directory_traversal${NC} - Read secret.txt"
    echo -e "   Flag format: FLAG{tr4v3rs4l_m4st3r}"
    echo ""
    echo -e "4. ${GREEN}auth_bypass${NC} - Access admin panel without proper login"
    echo -e "   Flag format: FLAG{4uth_byp4ss3d}"
    echo ""
}

# Verify challenge completion
verify_challenge() {
    local challenge="$1"

    case "$challenge" in
        sql_injection)
            echo -e "${CYAN}SQL Injection Challenge${NC}"
            echo -e "Did you successfully login as admin? (y/n)"
            read -p "> " answer
            if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
                echo -e "Enter the flag you found:"
                read -p "> " flag
                if [[ "$flag" == *"4dm1n_4cc3ss_gr4nt3d"* ]]; then
                    show_success
                    echo -e "${GREEN}SQL Injection Complete!${NC}"
                    echo -e "Code fragment: ${GREEN}CAT${NC}"
                    completed_challenges[sql_injection]=1
                    touch "$CHALLENGE_DIR/../../.solved_web_sql"
                    update_progress
                else
                    show_failure
                    echo -e "That's not the right flag. Keep trying!"
                fi
            fi
            ;;

        xss)
            echo -e "${CYAN}XSS Challenge${NC}"
            echo -e "Did you successfully execute JavaScript in a comment? (y/n)"
            read -p "> " answer
            if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
                show_success
                echo -e "${GREEN}XSS Challenge Complete!${NC}"
                echo -e "Code fragment: ${GREEN}-TA${NC}"
                completed_challenges[xss]=1
                touch "$CHALLENGE_DIR/../../.solved_web_xss"
                update_progress
            fi
            ;;

        directory_traversal)
            echo -e "${CYAN}Directory Traversal Challenge${NC}"
            echo -e "Did you read the secret.txt file? (y/n)"
            read -p "> " answer
            if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
                echo -e "Enter the flag you found:"
                read -p "> " flag
                if [[ "$flag" == *"tr4v3rs4l_m4st3r"* ]]; then
                    show_success
                    echo -e "${GREEN}Directory Traversal Complete!${NC}"
                    echo -e "Code fragment: ${GREEN}ST${NC}"
                    completed_challenges[directory_traversal]=1
                    touch "$CHALLENGE_DIR/../../.solved_web_traversal"
                    update_progress
                else
                    show_failure
                    echo -e "That's not the right flag. Keep trying!"
                fi
            fi
            ;;

        auth_bypass)
            echo -e "${CYAN}Authentication Bypass Challenge${NC}"
            echo -e "Did you access the admin panel? (y/n)"
            read -p "> " answer
            if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
                echo -e "Enter the flag from the admin panel:"
                read -p "> " flag
                if [[ "$flag" == *"4uth_byp4ss3d"* ]] || [[ "$flag" == *"4dm1n_4cc3ss_gr4nt3d"* ]]; then
                    show_success
                    echo -e "${GREEN}Authentication Bypass Complete!${NC}"
                    echo -e "Code fragment: ${GREEN}RO${NC}"
                    completed_challenges[auth_bypass]=1
                    touch "$CHALLENGE_DIR/../../.solved_web_auth"
                    update_progress
                else
                    show_failure
                    echo -e "That's not the right flag. Keep trying!"
                fi
            fi
            ;;

        *)
            echo -e "${RED}Unknown challenge: $challenge${NC}"
            echo -e "Use ${GREEN}list${NC} to see available challenges"
            ;;
    esac
}

# Show hints
show_hint() {
    local challenge="$1"

    case "$challenge" in
        sql_injection)
            echo -e "${MAGENTA}SQL Injection Hints:${NC}"
            echo -e "• Try: ${GREEN}' OR '1'='1${NC} in the username field"
            echo -e "• Or: ${GREEN}admin' --${NC} (with two dashes and a space)"
            echo -e "• Goal: Login as admin without knowing the password"
            ;;

        xss)
            echo -e "${MAGENTA}XSS Hints:${NC}"
            echo -e "• Go to any cat's profile page"
            echo -e "• Post a comment with: ${GREEN}<script>alert('XSS')</script>${NC}"
            echo -e "• Or try: ${GREEN}<img src=x onerror=alert(1)>${NC}"
            ;;

        directory_traversal)
            echo -e "${MAGENTA}Directory Traversal Hints:${NC}"
            echo -e "• Go to the Files page"
            echo -e "• Try: ${GREEN}../secret.txt${NC}"
            echo -e "• Or manually edit the URL: ${GREEN}/view-file?file=../secret.txt${NC}"
            ;;

        auth_bypass)
            echo -e "${MAGENTA}Authentication Bypass Hints:${NC}"
            echo -e "• Try accessing ${GREEN}/admin${NC} directly"
            echo -e "• Check your browser's cookies (F12 → Application → Cookies)"
            echo -e "• Try manually setting the ${GREEN}role${NC} cookie to ${GREEN}admin${NC}"
            echo -e "• In browser console: ${GREEN}document.cookie='role=admin'${NC}"
            ;;

        *)
            echo -e "${RED}Unknown challenge. Use ${GREEN}list${NC} to see available challenges${NC}"
            ;;
    esac
}

# Main loop
while true; do
    read -p "> " cmd args

    case "$cmd" in
        verify)
            if [ -z "$args" ]; then
                echo -e "${RED}Please specify a challenge.${NC} Use ${GREEN}list${NC} to see available challenges"
            else
                verify_challenge "$args"
            fi
            ;;

        hint)
            if [ -z "$args" ]; then
                echo -e "${RED}Please specify a challenge.${NC} Use ${GREEN}list${NC} to see available challenges"
            else
                show_hint "$args"
            fi
            ;;

        list)
            show_challenges
            ;;

        help)
            echo -e "${CYAN}Available commands:${NC}"
            echo -e "  ${GREEN}verify <challenge>${NC} - Verify challenge completion"
            echo -e "  ${GREEN}hint <challenge>${NC} - Get hints for a challenge"
            echo -e "  ${GREEN}list${NC} - List all challenges"
            echo -e "  ${GREEN}help${NC} - Show this help"
            echo -e "  ${GREEN}exit${NC} - Exit"
            ;;

        exit|quit)
            # Check if all challenges completed
            if [ ${#completed_challenges[@]} -eq 4 ]; then
                show_happy_cat
                echo -e "${GREEN}All web security challenges complete!${NC}"
                echo -e "Combined code: ${GREEN}CAT-TASTRO${NC}"
            fi
            exit 0
            ;;

        *)
            echo -e "${RED}Unknown command.${NC} Type ${GREEN}help${NC} for available commands."
            ;;
    esac
done
