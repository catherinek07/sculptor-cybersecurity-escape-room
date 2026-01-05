#!/usr/bin/env python3
"""
Cat-astrophic Security - Challenge 2: Hash Cracking

VULNERABILITY: Weak passwords with MD5 hashing
GOAL: Crack the MD5 hash to find the password

Educational purposes only!
"""

import hashlib

def print_banner():
    print("""
     /\_/\\
    ( ^.^ )
     > ^ <
    /|   |\\
   (_|   |_)
    """)

def md5_hash(text):
    return hashlib.md5(text.encode()).hexdigest()

# Wordlist of common cat-themed passwords
WORDLIST = [
    "cat", "kitten", "meow", "purr", "whiskers", "mittens", "fluffy",
    "tabby", "calico", "persian", "siamese", "catnip", "kitty", "feline",
    "paws", "claws", "furball", "hairball", "catfish", "catastrophe",
    "cat123", "meow123", "admin", "password", "12345", "tuna", "fish"
]

def main():
    print_banner()
    print("=" * 55)
    print("  🐱 Cat Cafe Crypto Challenge 2: Hash Cracking")
    print("=" * 55)
    print()

    # The "secret" password
    secret_password = "catnip"
    target_hash = md5_hash(secret_password)

    print("We found a password hash in the database:")
    print()
    print(f"  Hash: {target_hash}")
    print()
    print("Can you crack it using a dictionary attack?")
    print()
    print("💡 Hints:")
    print("  • The hash is MD5 (128-bit)")
    print("  • Try common cat-related passwords")
    print("  • Use a wordlist attack")
    print()
    print(f"Available wordlist has {len(WORDLIST)} entries")
    print()

    print("Options:")
    print("  1. Manual guess")
    print("  2. Automatic brute force")
    print("  3. Show wordlist")
    print("  4. Exit")
    print()

    while True:
        choice = input("Choose an option (1-4): ").strip()

        if choice == '1':
            guess = input("Enter password guess: ").strip()
            guess_hash = md5_hash(guess)

            print(f"\nYour guess: {guess}")
            print(f"MD5 hash:   {guess_hash}")
            print()

            if guess_hash == target_hash:
                print("=" * 55)
                print("  🎉 SUCCESS! You cracked the hash!")
                print("=" * 55)
                print()
                print(f"Password: {guess}")
                print(f"Your flag: FLAG{{h4sh_cr4ck3r_pr0}}")
                print()
                print("Code fragment: -PTO")
                print()
                break
            else:
                print("❌ Wrong password. Try again!")
                print()

        elif choice == '2':
            print("\nRunning dictionary attack...")
            print()

            found = False
            for i, word in enumerate(WORDLIST):
                word_hash = md5_hash(word)
                print(f"Trying: {word:20s} -> {word_hash}", end='')

                if word_hash == target_hash:
                    print(" ✓ MATCH!")
                    print()
                    print("=" * 55)
                    print("  🎉 SUCCESS! Password cracked!")
                    print("=" * 55)
                    print()
                    print(f"Password: {word}")
                    print(f"Your flag: FLAG{{h4sh_cr4ck3r_pr0}}")
                    print()
                    print("Code fragment: -PTO")
                    print()
                    found = True
                    break
                else:
                    print(" ✗")

            if found:
                break
            else:
                print("\n❌ Password not in wordlist!")
                print()

        elif choice == '3':
            print("\nAvailable passwords in wordlist:")
            for i, word in enumerate(WORDLIST, 1):
                print(f"  {i:2d}. {word}")
            print()

        elif choice == '4':
            print("Goodbye! 🐾")
            break

        else:
            print("Invalid choice. Please enter 1-4.")

if __name__ == "__main__":
    main()
