#!/bin/bash

# 3D Cat Cafe Escape Room Launcher
# This script starts the web server for the 3D escape room experience

set -e

echo "═══════════════════════════════════════════════════"
echo "  🎮 3D CAT CAFE ESCAPE ROOM"
echo "═══════════════════════════════════════════════════"
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Error: Node.js is not installed!"
    echo ""
    echo "Please install Node.js first:"
    echo "  - Visit: https://nodejs.org/"
    echo "  - Or use a package manager:"
    echo "    • macOS: brew install node"
    echo "    • Ubuntu/Debian: sudo apt install nodejs npm"
    echo "    • Fedora: sudo dnf install nodejs"
    echo ""
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ Error: npm is not installed!"
    echo ""
    echo "Please install npm (usually comes with Node.js)"
    exit 1
fi

echo "✓ Node.js $(node --version) detected"
echo "✓ npm $(npm --version) detected"
echo ""

# Navigate to web_app directory
cd "$(dirname "$0")/web_app"

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    echo ""
    npm install
    echo ""
    echo "✓ Dependencies installed!"
    echo ""
fi

echo "═══════════════════════════════════════════════════"
echo "  🚀 Starting 3D Escape Room Server..."
echo "═══════════════════════════════════════════════════"
echo ""
echo "  🌐 URL: http://localhost:3000"
echo "  📝 Click: 'Enter the 3D Escape Room!' link"
echo ""
echo "  Controls:"
echo "    • WASD - Move around"
echo "    • Mouse - Look around"
echo "    • E - Interact with terminals"
echo "    • ESC - Close panels"
echo ""
echo "  Press Ctrl+C to stop the server"
echo "═══════════════════════════════════════════════════"
echo ""

# Start the server
npm start
