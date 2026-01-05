#!/usr/bin/env python3
"""
Cat-astrophic Security - Challenge 4: Weak RSA

VULNERABILITY: Small RSA primes
GOAL: Factor N and decrypt the message

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

def gcd(a, b):
    """Calculate greatest common divisor"""
    while b:
        a, b = b, a % b
    return a

def mod_inverse(e, phi):
    """Calculate modular multiplicative inverse"""
    def extended_gcd(a, b):
        if a == 0:
            return b, 0, 1
        gcd_val, x1, y1 = extended_gcd(b % a, a)
        x = y1 - (b // a) * x1
        y = x1
        return gcd_val, x, y

    _, x, _ = extended_gcd(e % phi, phi)
    return (x % phi + phi) % phi

def rsa_encrypt(m, e, n):
    """RSA encryption: c = m^e mod n"""
    return pow(m, e, n)

def rsa_decrypt(c, d, n):
    """RSA decryption: m = c^d mod n"""
    return pow(c, d, n)

def factor_n(n):
    """Simple factorization for small numbers"""
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            return i, n // i
    return None, None

def main():
    print_banner()
    print("=" * 55)
    print("  🐱 Cat Cafe Crypto Challenge 4: Weak RSA")
    print("=" * 55)
    print()

    # INTENTIONALLY WEAK - Small primes for educational purposes
    p = 1009  # Prime 1
    q = 1013  # Prime 2
    n = p * q
    e = 65537  # Common public exponent
    phi = (p - 1) * (q - 1)
    d = mod_inverse(e, phi)

    # Encrypt the flag
    message = "MITTENS"
    m = int.from_bytes(message.encode(), 'big')
    c = rsa_encrypt(m, e, n)

    print("RSA Public Key:")
    print(f"  n = {n}")
    print(f"  e = {e}")
    print()
    print(f"Encrypted message: {c}")
    print()
    print("💡 Challenge: Factor n to find p and q, then decrypt!")
    print()
    print("RSA Security relies on the difficulty of factoring large numbers.")
    print("But these numbers are small enough to factor easily!")
    print()

    while True:
        print("Options:")
        print("  1. Try factoring n manually")
        print("  2. Auto-factor and decrypt")
        print("  3. Show RSA math")
        print("  4. Exit")
        print()

        choice = input("Choose an option (1-4): ").strip()

        if choice == '1':
            try:
                p_guess = int(input("Enter p (first prime factor): ").strip())
                q_guess = int(input("Enter q (second prime factor): ").strip())

                if p_guess * q_guess == n:
                    print()
                    print("✓ Correct factors!")
                    print()

                    # Calculate private key
                    phi_calc = (p_guess - 1) * (q_guess - 1)
                    d_calc = mod_inverse(e, phi_calc)

                    print(f"φ(n) = (p-1)(q-1) = {phi_calc}")
                    print(f"d = e^(-1) mod φ(n) = {d_calc}")
                    print()

                    # Decrypt
                    m_decrypted = rsa_decrypt(c, d_calc, n)
                    decrypted_bytes = m_decrypted.to_bytes((m_decrypted.bit_length() + 7) // 8, 'big')
                    decrypted_message = decrypted_bytes.decode()

                    print(f"Decrypted message: {decrypted_message}")
                    print()
                    print("=" * 55)
                    print("  🎉 SUCCESS! RSA cracked!")
                    print("=" * 55)
                    print()
                    print(f"Your flag: FLAG{{rs4_f4ct0r3d}}")
                    print()
                    print("Code fragment: -PHY")
                    print()
                    break
                else:
                    print(f"\n❌ Wrong! {p_guess} × {q_guess} = {p_guess * q_guess} ≠ {n}\n")

            except ValueError:
                print("Please enter valid numbers!")
            except Exception as e:
                print(f"Error: {e}")

        elif choice == '2':
            print()
            print("Factoring n...")
            print()

            p_found, q_found = factor_n(n)

            if p_found and q_found:
                print(f"✓ Found factors: p = {p_found}, q = {q_found}")
                print(f"✓ Verification: {p_found} × {q_found} = {n}")
                print()

                phi_calc = (p_found - 1) * (q_found - 1)
                d_calc = mod_inverse(e, phi_calc)

                print(f"Calculating private key:")
                print(f"  φ(n) = {phi_calc}")
                print(f"  d = {d_calc}")
                print()

                m_decrypted = rsa_decrypt(c, d_calc, n)
                decrypted_bytes = m_decrypted.to_bytes((m_decrypted.bit_length() + 7) // 8, 'big')
                decrypted_message = decrypted_bytes.decode()

                print(f"Decrypted message: {decrypted_message}")
                print()
                print("=" * 55)
                print("  🎉 SUCCESS! RSA cracked!")
                print("=" * 55)
                print()
                print(f"Your flag: FLAG{{rs4_f4ct0r3d}}")
                print()
                print("Code fragment: -PHY")
                print()
                break

        elif choice == '3':
            print()
            print("RSA Mathematics:")
            print()
            print("Key Generation:")
            print("  1. Choose two prime numbers: p and q")
            print("  2. Calculate n = p × q")
            print("  3. Calculate φ(n) = (p-1) × (q-1)")
            print("  4. Choose e (commonly 65537)")
            print("  5. Calculate d = e^(-1) mod φ(n)")
            print()
            print("Encryption: c = m^e mod n")
            print("Decryption: m = c^d mod n")
            print()
            print("Security: Hard to factor large n back to p and q")
            print("Weakness: If n is small, factoring is easy!")
            print()

        elif choice == '4':
            print("Goodbye! 🐾")
            break

        else:
            print("Invalid choice. Please enter 1-4.")

if __name__ == "__main__":
    main()
