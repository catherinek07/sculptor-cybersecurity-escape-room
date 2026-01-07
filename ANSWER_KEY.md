# 🔑 Cat Cafe Escape Room - Answer Key

This file contains all the answers to test the game without solving everything manually.

## 🌐 Web Exploitation Room (5 challenges)

### 1. SQL Injection
- **Challenge:** Bypass the login system
- **Answer:** `' OR '1'='1`
- **Flag:** `FLAG{web_sql_s0lv3d}`
- **Explanation:** Basic SQL injection using OR condition to bypass authentication

### 2. XSS Attack
- **Challenge:** Inject JavaScript
- **Answer:** `<script>alert('xss')</script>`
- **Alternative:** `<img src=x onerror=alert('xss')>`
- **Flag:** `FLAG{web_xss_s0lv3d}`
- **Explanation:** Cross-site scripting by injecting script tags

### 3. Directory Traversal
- **Challenge:** Access secret files
- **Answer:** `../../../secret.txt` or any path containing `..` or `secret`
- **Flag:** `FLAG{web_traversal_s0lv3d}`
- **Explanation:** Use path traversal to access files outside web root

### 4. Auth Bypass
- **Challenge:** Forge admin cookie
- **Answer:** `admin` or `role=admin`
- **Flag:** `FLAG{web_auth_s0lv3d}`
- **Explanation:** Set cookie to impersonate admin user

### 5. Cat Database
- **Challenge:** Find Mittens' location
- **Answer:** `ventilation` or `vent` or `ventilation system`
- **Flag:** `FLAG{web_cats_s0lv3d}`
- **Explanation:** Mittens is hidden in the ventilation system (found in secret_location column)

---

## 🔐 Cryptography Room (5 challenges)

### 1. Caesar Cipher
- **Challenge:** Decrypt "Wkh fdw klghv wkh nh|"
- **Answer:** `the cat hides the key`
- **Flag:** `FLAG{crypto_caesar_s0lv3d}`
- **Explanation:** Caesar cipher with shift of 3 (ROT3)

### 2. Hash Cracking
- **Challenge:** Crack MD5 hash `5f4dcc3b5aa765d61d8327deb882cf99`
- **Answer:** `password`
- **Flag:** `FLAG{crypto_hash_s0lv3d}`
- **Explanation:** Common password hash, easily cracked with rainbow tables

### 3. XOR Decryption
- **Challenge:** Decrypt hex `1a1b1c1d1e1f` with single byte key
- **Answer:** Contains `meow` (accept any answer with "meow")
- **Flag:** `FLAG{crypto_xor_s0lv3d}`
- **Explanation:** Single-byte XOR cipher, try all 256 possible keys

### 4. Weak RSA
- **Challenge:** Decrypt with n=143, e=7, c=42
- **Answer:** `2`
- **Flag:** `FLAG{crypto_rsa_s0lv3d}`
- **Explanation:** n=143 factors to 11×13, allowing decryption

### 5. Base64 Layers
- **Challenge:** Decode multiple layers of Base64
- **Answer:** Contains `cat` (accept any answer with "cat")
- **Flag:** `FLAG{crypto_base64_s0lv3d}`
- **Explanation:** Recursively decode Base64 until plaintext appears

---

## 💥 Binary Exploitation Room (3 challenges)

### 1. Buffer Overflow
- **Challenge:** Exploit buffer overflow in binary
- **Answer:** Any input containing `FLAG{` or `flag{`
- **Flag:** `FLAG{binary_buffer_s0lv3d}`
- **Explanation:** Overwrite return address to execute arbitrary code
- **Binary:** `challenges/binary/challenge1`

### 2. Format String
- **Challenge:** Exploit format string vulnerability
- **Answer:** Any input containing `FLAG{` or `flag{`
- **Flag:** `FLAG{binary_format_s0lv3d}`
- **Explanation:** Use format specifiers like %x to read/write memory
- **Binary:** `challenges/binary/challenge2`

### 3. Shellcode Injection
- **Challenge:** Inject and execute shellcode
- **Answer:** Any input containing `FLAG{` or `flag{`
- **Flag:** `FLAG{binary_shellcode_s0lv3d}`
- **Explanation:** Inject executable code into the program
- **Binary:** `challenges/binary/challenge3`

---

## 🔓 Reverse Engineering Room (2 challenges)

### 1. Keygen
- **Challenge:** Generate valid license key
- **Answer:** Any input containing `CAT-` (e.g., `CAT-1234`)
- **Flag:** `FLAG{reverse_keygen_s0lv3d}`
- **Explanation:** Reverse the key validation algorithm
- **Binary:** `challenges/reverse/challenge1`

### 2. Password Check
- **Challenge:** Find the correct password
- **Answer:** Contains `meow` (e.g., `meow`, `meow123`)
- **Flag:** `FLAG{reverse_password_s0lv3d}`
- **Explanation:** Reverse engineer the password checking logic
- **Binary:** `challenges/reverse/challenge2`

---

## 📷 Forensics Room (1 challenge)

### 1. Cat Photo Analysis
- **Challenge:** Analyze images for hidden data
- **Answer:** Any input containing `FLAG{` or `flag{`
- **Flag:** `FLAG{forensics_photos_s0lv3d}`
- **Explanation:** Check image metadata, steganography, or hidden data
- **Files:** `challenges/forensics/`

---

## 🎮 Game Mechanics

### Room Unlocking System
- **Web Room:** Start with this door OPEN
- **Other Rooms:** Locked until you complete all challenges in the previous rooms
  - Crypto: Unlocks after 5/5 Web challenges
  - Binary: Unlocks after 5/5 Crypto challenges
  - Reverse: Unlocks after 3/3 Binary challenges
  - Forensics: Unlocks after 2/2 Reverse challenges

### Controls
- **WASD:** Move around
- **Mouse:** Look around
- **SPACE:** Jump
- **E:** Interact with terminals/hints OR close panels
- **ESC:** Toggle between EXPLORE mode and UI mode
  - **EXPLORE mode:** You can move and look around
  - **UI mode:** You can interact with panels (WASD/mouse disabled)

### Hints
- Yellow glowing spheres scattered in each room
- Press **E** when close to read hints
- Each room has 3-5 hint objects

### Terminal
- Bottom right corner (movable by dragging the header)
- Commands:
  - `help` - Show available commands
  - `status` - Show current status
  - `flags` - List found flags
  - `rooms` - Show room completion status
  - `clear` - Clear terminal output

---

## 🏆 Quick Test Solutions

To quickly test all challenges, use these inputs:

```
Web Room:
- SQL: '
- XSS: <script>
- Traversal: ../secret
- Auth: admin
- Cats: ventilation

Crypto Room:
- Caesar: the cat hides the key
- Hash: password
- XOR: meow
- RSA: 2
- Base64: cat

Binary Room:
- Buffer: FLAG{test}
- Format: FLAG{test}
- Shellcode: FLAG{test}

Reverse Room:
- Keygen: CAT-1234
- Password: meow123

Forensics Room:
- Photos: FLAG{test}
```

---

## 🎨 Color Scheme (ABCDEF only)

All colors in the game use only the hex digits A, B, C, D, E, F:

- **Background:** `#aabbcc`
- **UI Green:** `#aaffbb`
- **Web Room:** `#aaffbb` (green-ish)
- **Crypto Room:** `#ffaabb` (pink-ish)
- **Binary Room:** `#ffbbaa` (orange-ish)
- **Reverse Room:** `#aabbff` (blue-ish)
- **Forensics Room:** `#ffeedd` (cream)
- **Walls:** `#abcdef`
- **Floors:** `#bcdeef`
- **Hints:** `#ffddaa`

---

## 📝 Notes

- Total flags: **16** (5 + 5 + 3 + 2 + 1)
- The game tracks which challenges you've solved
- Doors remain unlocked once opened
- You can return to the lobby from any room through the exit door
- Progress is saved in the current session (no persistence between page reloads)

---

**Have fun testing! 🐱**
