#!/usr/bin/env python3
"""
Cat-astrophic Security - Challenge 1: Caesar Cipher

VULNERABILITY: Weak substitution cipher
GOAL: Decrypt the Caesar cipher to find the flag

Educational purposes only!
"""

def print_banner():
    print("""
     /\_/\\
    ( o.o )
     > ^ <
    /|   |\\
   (_|   |_)
    """)

def caesar_encrypt(text, shift):
    result = ""
    for char in text:
        if char.isalpha():
            start = ord('A') if char.isupper() else ord('a')
            result += chr((ord(char) - start + shift) % 26 + start)
        else:
            result += char
    return result

def main():
    print_banner()
    print("=" * 50)
    print("  🐱 Cat Cafe Crypto Challenge 1: Caesar Cipher")
    print("=" * 50)
    print()

    secret_message = "XLMW MW XLMW ZEW E VIEPP FMKKIV GLEPIRKKI"
    flag = "FLAG{c43s4r_c1ph3r_cr4ck3d}"
    encrypted_flag = caesar_encrypt(flag, 4)

    print("We intercepted an encrypted message from the hacker:")
    print()
    print(f"  Message: {secret_message}")
    print(f"  Flag:    {encrypted_flag}")
    print()
    print("This looks like a Caesar cipher!")
    print()
    print("💡 Hints:")
    print("  • Caesar cipher shifts each letter by a fixed amount")
    print("  • There are only 26 possible shifts to try")
    print("  • Try all shifts and look for readable text")
    print("  • The flag format is FLAG{...}")
    print()

    while True:
        try:
            shift = input("Enter the shift value (0-25) or 'hint' for help: ").strip()

            if shift.lower() == 'hint':
                print()
                print("The message 'XLMW' might decrypt to 'THIS'")
                print("X -> T is a shift of 4")
                print("Try shift value: 22 (or -4, which is 26-4=22)")
                print()
                continue

            if shift.lower() in ['exit', 'quit']:
                print("Goodbye! 🐾")
                break

            shift = int(shift)

            if shift < 0 or shift > 25:
                print("Shift must be between 0 and 25!")
                continue

            decrypted_message = caesar_encrypt(secret_message, shift)
            decrypted_flag = caesar_encrypt(encrypted_flag, shift)

            print()
            print(f"Decrypted message: {decrypted_message}")
            print(f"Decrypted flag:    {decrypted_flag}")
            print()

            if "FLAG{c43s4r_c1ph3r_cr4ck3d}" in decrypted_flag:
                print("=" * 50)
                print("  🎉 SUCCESS! You cracked the Caesar cipher!")
                print("=" * 50)
                print()
                print(f"Your flag: {flag}")
                print()
                print("Code fragment: CRY")
                print()
                break
            else:
                print("Not quite right. Try another shift value!")
                print()

        except ValueError:
            print("Please enter a valid number or 'hint'")
        except KeyboardInterrupt:
            print("\nGoodbye! 🐾")
            break

if __name__ == "__main__":
    main()
