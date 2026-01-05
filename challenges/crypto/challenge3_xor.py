#!/usr/bin/env python3
"""
Cat-astrophic Security - Challenge 3: XOR Cipher

VULNERABILITY: XOR with a repeating key
GOAL: Break the XOR cipher to reveal the message

Educational purposes only!
"""

def print_banner():
    print("""
     /\_/\\
    ( -.- )
     > ^ <
    /|   |\\
   (_|   |_)
    """)

def xor_encrypt(plaintext, key):
    """XOR encrypt with repeating key"""
    result = []
    for i, char in enumerate(plaintext):
        key_char = key[i % len(key)]
        result.append(chr(ord(char) ^ ord(key_char)))
    return ''.join(result)

def xor_decrypt(ciphertext, key):
    """XOR is its own inverse"""
    return xor_encrypt(ciphertext, key)

def to_hex(text):
    """Convert string to hex representation"""
    return ''.join(f'{ord(c):02x}' for c in text)

def from_hex(hex_str):
    """Convert hex to string"""
    return ''.join(chr(int(hex_str[i:i+2], 16)) for i in range(0, len(hex_str), 2))

def main():
    print_banner()
    print("=" * 55)
    print("  🐱 Cat Cafe Crypto Challenge 3: XOR Cipher")
    print("=" * 55)
    print()

    secret_message = "The cats are hidden in the basement behind the scratching post"
    secret_key = "CAT"
    encrypted = xor_encrypt(secret_message, secret_key)
    encrypted_hex = to_hex(encrypted)

    print("We intercepted an XOR-encrypted message:")
    print()
    print(f"Encrypted (hex): {encrypted_hex}")
    print()
    print("💡 Hints:")
    print("  • XOR encryption uses: ciphertext = plaintext XOR key")
    print("  • XOR is reversible: plaintext = ciphertext XOR key")
    print("  • The key is short and repeating")
    print("  • Known plaintext: message starts with 'The'")
    print("  • If you know plaintext and ciphertext, you can find the key!")
    print()
    print("Key length hint: 3 characters")
    print()

    # Show XOR properties
    print("Understanding XOR:")
    print("  If: C = P XOR K")
    print("  Then: P = C XOR K")
    print("  And: K = P XOR C")
    print()

    while True:
        print("Options:")
        print("  1. Try decrypting with a key")
        print("  2. Show how to find the key")
        print("  3. Auto-solve")
        print("  4. Exit")
        print()

        choice = input("Choose an option (1-4): ").strip()

        if choice == '1':
            key = input("Enter the key: ").strip()
            decrypted = xor_decrypt(encrypted, key)

            print()
            print(f"Decrypted: {decrypted}")
            print()

            if "cats are hidden in the basement" in decrypted.lower():
                print("=" * 55)
                print("  🎉 SUCCESS! XOR cipher broken!")
                print("=" * 55)
                print()
                print(f"Key: {key}")
                print(f"Message: {decrypted}")
                print(f"Your flag: FLAG{{x0r_c1ph3r_br0k3n}}")
                print()
                print("Code fragment: -GRA")
                print()
                break
            else:
                print("❌ Not quite right. Try again!")
                print()

        elif choice == '2':
            print()
            print("Finding the key:")
            print()
            print("Known plaintext: 'The'")
            print(f"Ciphertext (first 3 bytes hex): {encrypted_hex[:6]}")
            print()
            print("XOR property: Key = Plaintext XOR Ciphertext")
            print()

            # Calculate the key
            known_plain = "The"
            cipher_bytes = encrypted[:3]
            found_key = xor_encrypt(known_plain, cipher_bytes)

            print(f"Calculated key: {found_key}")
            print()
            print("Try this key to decrypt the message!")
            print()

        elif choice == '3':
            print()
            print("Auto-solving...")
            print()

            # Known plaintext attack
            known_plain = "The"
            cipher_start = encrypted[:3]
            found_key = xor_encrypt(known_plain, cipher_start)

            print(f"Found key using known plaintext: {found_key}")
            decrypted = xor_decrypt(encrypted, found_key)

            print(f"Decrypted message: {decrypted}")
            print()
            print("=" * 55)
            print("  🎉 SUCCESS! XOR cipher broken!")
            print("=" * 55)
            print()
            print(f"Your flag: FLAG{{x0r_c1ph3r_br0k3n}}")
            print()
            print("Code fragment: -GRA")
            print()
            break

        elif choice == '4':
            print("Goodbye! 🐾")
            break

        else:
            print("Invalid choice. Please enter 1-4.")

if __name__ == "__main__":
    main()
