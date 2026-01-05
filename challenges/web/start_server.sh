#!/bin/bash

# Start the vulnerable web application

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WEB_APP_DIR="$SCRIPT_DIR/../../web_app"

source "$SCRIPT_DIR/../../scripts/game_engine.sh"

show_banner
echo -e "${CYAN}Starting Cat Cafe Web Application...${NC}"
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo -e "${RED}Error: Node.js is not installed!${NC}"
    echo -e "Please install Node.js from: ${GREEN}https://nodejs.org/${NC}"
    echo ""
    exit 1
fi

# Check if dependencies are installed
if [ ! -d "$WEB_APP_DIR/node_modules" ]; then
    echo -e "${YELLOW}Installing dependencies...${NC}"
    echo ""
    cd "$WEB_APP_DIR"
    npm install
    echo ""
fi

# Start the server
echo -e "${GREEN}Starting server...${NC}"
echo ""
cd "$WEB_APP_DIR"
node server.js
