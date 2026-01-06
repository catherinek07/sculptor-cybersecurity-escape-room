# 🎮 3D Cat Cafe Escape Room

An immersive first-person 3D escape room experience that integrates all the cybersecurity challenges from the Cat Cafe CTF platform!

## 🌟 Features

### Immersive 3D Environment
- **First-person perspective** with WASD movement and mouse look controls
- **Multiple challenge areas** organized by category:
  - 🌐 **Web Exploitation Zone** (Green terminals) - SQL Injection, XSS, Directory Traversal, Auth Bypass
  - 🔐 **Cryptography Area** (Purple terminals) - Caesar Cipher, Hash Cracking, XOR, RSA, Base64
  - 💥 **Binary Exploitation Area** (Red terminals) - Buffer Overflow, Format String, Shellcode
  - 🔓 **Reverse Engineering Zone** (Cyan terminals) - Keygen, Password Check
  - 📷 **Forensics Section** (Yellow terminal) - Cat Photo Analysis

### Interactive Challenge Terminals
- Click on any terminal screen to interact with challenges
- Real-time flag verification
- Progress tracking (flags found counter)
- Color-coded challenge categories

### Built with Three.js
- WebGL-powered 3D graphics
- Smooth physics and movement
- Atmospheric lighting and fog effects
- Cat decorations scattered throughout

## 🚀 Getting Started

### Prerequisites
- Node.js and npm installed
- The web application dependencies

### Installation

1. Navigate to the web_app directory:
```bash
cd web_app
```

2. Install dependencies (if not already installed):
```bash
npm install
```

3. Start the server:
```bash
npm start
```

4. Open your browser and navigate to:
```
http://localhost:3000
```

5. Click on **"Enter the 3D Escape Room!"** link from the homepage

## 🎮 Controls

- **WASD** - Move around the escape room
- **Mouse** - Look around (click to lock cursor)
- **E** - Interact with terminals and objects
- **ESC** - Close challenge panels
- **Click** - Lock/unlock pointer

## 🗺️ Room Layout

```
                    BACK WALL
    ┌─────────────────────────────────────┐
    │  CRYPTO     │         │    WEB      │
    │  AREA       │         │    AREA     │
    │  (Purple)   │         │   (Green)   │
    │             │         │             │
    │  🔐🔐🔐    │   📷    │    🌐🌐🌐   │
    │             │(Yellow) │             │
LEFT│             │         │             │RIGHT
    │             │         │             │
    │  REVERSE    │         │   BINARY    │
    │  (Cyan)     │         │    (Red)    │
    │             │         │             │
    │   🔓🔓     │         │    💥💥💥   │
    └─────────────────────────────────────┘
                   FRONT WALL
                  (Entry Point)
```

## 🎯 Challenge Categories

### Web Exploitation (5 challenges)
- **SQL Injection** - Bypass authentication
- **XSS Attack** - Inject JavaScript
- **Directory Traversal** - Access secret files
- **Auth Bypass** - Forge admin cookies
- **Cat Database** - Find hidden information

### Cryptography (5 challenges)
- **Caesar Cipher** - Decrypt shifted text
- **Hash Cracking** - Crack MD5 hash
- **XOR Decryption** - Find the key
- **Weak RSA** - Factor small modulus
- **Base64 Layers** - Decode multiple layers

### Binary Exploitation (3 challenges)
- **Buffer Overflow** - Overwrite return address
- **Format String** - Exploit printf vulnerability
- **Shellcode Injection** - Execute arbitrary code

### Reverse Engineering (2 challenges)
- **Keygen** - Generate valid license keys
- **Password Check** - Find the correct password

### Forensics (1 challenge)
- **Cat Photos** - Analyze images for hidden data

## 🏆 Winning the Game

- Complete all 15+ challenges to escape the room
- Each solved challenge awards a flag
- Track your progress with the HUD flag counter
- Some challenges require external tools (for binary/reverse challenges)

## 💡 Tips

1. **Look around** - Terminals are color-coded by category
2. **Get close** - Walk up to terminals before pressing E
3. **Read carefully** - Each challenge has hints
4. **Web challenges** - Can be solved directly in the 3D interface
5. **Binary/Reverse challenges** - May require terminal access to binaries
6. **Take notes** - Write down flags as you find them

## 🔧 Technical Details

### Technologies Used
- **Three.js** (r128) - 3D rendering engine
- **Express.js** - Web server
- **Pointer Lock API** - First-person controls
- **EJS** - Templating

### Performance
- Optimized for modern browsers
- Runs at 60 FPS on most hardware
- Uses fog and lighting for atmosphere
- Collision detection keeps player in bounds

## 🐛 Troubleshooting

### Mouse not locking
- Click anywhere on the screen to activate pointer lock
- Some browsers require user interaction first

### Can't move
- Make sure you've clicked to lock the pointer
- Check that you're using WASD keys

### Terminal not responding
- Get closer to the terminal
- Make sure you're looking at it (crosshair on screen)
- Press E to interact

### Performance issues
- Close other browser tabs
- Update your graphics drivers
- Try a different browser (Chrome/Firefox recommended)

## 🎨 Customization

Want to add more challenges or modify the room? Edit these files:

- `web_app/views/escape_room_3d.ejs` - Main 3D scene and logic
- `web_app/server.js` - Add new routes and endpoints

### Adding a New Terminal

```javascript
createTerminal(x, y, z, color, 'LABEL', 'category', 'challengeId');
```

Example:
```javascript
createTerminal(10, 2, 5, 0xff00ff, 'NEW CHALLENGE', 'crypto', 'newChallenge');
```

Then add the challenge content in the `getChallengeContent()` function.

## 📝 Challenge Solutions

(Spoilers ahead!)

<details>
<summary>Click to reveal hints</summary>

### Web Challenges
- **SQL Injection**: `' OR '1'='1`
- **XSS**: `<script>alert('xss')</script>`
- **Directory Traversal**: `../../../secret.txt`
- **Auth Bypass**: Set cookie `role=admin`

### Crypto Challenges
- **Caesar**: Shift by 3
- **Hash**: Common password
- **XOR**: Try single-byte keys
- **RSA**: Factor 143 = 11 × 13
- **Base64**: Decode recursively

</details>

## 🤝 Contributing

This is an educational project. Feel free to:
- Add new challenges
- Improve the 3D environment
- Add more interactive objects
- Create additional rooms

## ⚠️ Security Warning

**This application contains intentional vulnerabilities for educational purposes.**
- Do NOT deploy to production
- Do NOT expose to the internet
- Use ONLY in controlled learning environments

## 📜 License

MIT License - Educational purposes only

## 🎉 Have Fun!

Enjoy exploring the 3D escape room and learning about cybersecurity! Good luck finding all the flags! 🐱

---

**Made with ❤️ using Three.js and Express.js**
