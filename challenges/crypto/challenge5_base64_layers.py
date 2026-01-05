#!/usr/bin/env python3
"""
Cat-astrophic Security - Challenge 5: Multi-Layer Encoding

VULNERABILITY: Multiple layers of Base64 encoding
GOAL: Decode all layers to find the flag

Educational purposes only!
"""

import base64

def print_banner():
    print("""
     /\_/\\
    ( ^.^ )
     > ^ <
    /|   |\\
   (_|   |_)
    """)

def encode_multiple(text, layers):
    """Encode text multiple times with Base64"""
    encoded = text.encode()
    for i in range(layers):
        encoded = base64.b64encode(encoded)
    return encoded.decode()

def decode_layer(encoded_text):
    """Try to decode one layer of Base64"""
    try:
        decoded = base64.b64decode(encoded_text.encode())
        return decoded.decode()
    except:
        return None

def main():
    print_banner()
    print("=" * 60)
    print("  🐱 Cat Cafe Crypto Challenge 5: Multi-Layer Encoding")
    print("=" * 60)
    print()

    secret = "The secret code is: PURR-FECT-MEOW-2024"
    layers = 5
    encoded = encode_multiple(secret, layers)

    print("We found a message encoded with multiple layers of Base64:")
    print()
    print(f"Encoded ({layers} layers):")
    print(f"{encoded}")
    print()
    print("💡 Hints:")
    print("  • Base64 encoding is easily reversible")
    print("  • You need to decode multiple times")
    print("  • Each decode gives you another Base64 string")
    print("  • Keep decoding until you get readable text")
    print()

    current_text = encoded
    layer_count = 0

    while True:
        print(f"Current text (Layer {layer_count}):")
        print(f"{current_text[:80]}{'...' if len(current_text) > 80 else ''}")
        print()

        print("Options:")
        print("  1. Decode one layer")
        print("  2. Auto-decode all layers")
        print("  3. Show current full text")
        print("  4. Reset")
        print("  5. Exit")
        print()

        choice = input("Choose an option (1-5): ").strip()

        if choice == '1':
            decoded = decode_layer(current_text)

            if decoded:
                layer_count += 1
                current_text = decoded
                print()
                print(f"✓ Decoded layer {layer_count}")
                print()

                if "secret code" in current_text.lower():
                    print("=" * 60)
                    print("  🎉 SUCCESS! All layers decoded!")
                    print("=" * 60)
                    print()
                    print(f"Final message: {current_text}")
                    print()
                    print(f"Your flag: FLAG{{l4y3r3d_3nc0d1ng}}")
                    print()
                    print("Code fragment: -FER")
                    print()
                    break
            else:
                print()
                print("❌ Failed to decode. This might be the final layer!")
                print(f"Text: {current_text}")
                print()

                if "secret code" in current_text.lower():
                    print("=" * 60)
                    print("  🎉 SUCCESS! All layers decoded!")
                    print("=" * 60)
                    print()
                    print(f"Your flag: FLAG{{l4y3r3d_3nc0d1ng}}")
                    print()
                    print("Code fragment: -FER")
                    print()
                    break

        elif choice == '2':
            print()
            print("Auto-decoding all layers...")
            print()

            temp_text = current_text
            temp_layer = layer_count

            while True:
                decoded = decode_layer(temp_text)

                if decoded and decoded != temp_text:
                    temp_layer += 1
                    print(f"Layer {temp_layer}: {decoded[:60]}{'...' if len(decoded) > 60 else ''}")
                    temp_text = decoded

                    if "secret code" in temp_text.lower():
                        print()
                        print("=" * 60)
                        print("  🎉 SUCCESS! All layers decoded!")
                        print("=" * 60)
                        print()
                        print(f"Final message: {temp_text}")
                        print(f"Total layers: {temp_layer}")
                        print()
                        print(f"Your flag: FLAG{{l4y3r3d_3nc0d1ng}}")
                        print()
                        print("Code fragment: -FER")
                        print()
                        return
                else:
                    break

            current_text = temp_text
            layer_count = temp_layer
            print()

        elif choice == '3':
            print()
            print("Full current text:")
            print(current_text)
            print()

        elif choice == '4':
            current_text = encoded
            layer_count = 0
            print()
            print("✓ Reset to original encoded text")
            print()

        elif choice == '5':
            print("Goodbye! 🐾")
            break

        else:
            print("Invalid choice. Please enter 1-5.")

if __name__ == "__main__":
    main()
