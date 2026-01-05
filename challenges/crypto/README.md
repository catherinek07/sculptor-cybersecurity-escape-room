# 🔐 Cryptography Challenges

Coming Soon! This section will include:

## Planned Challenges

1. **Caesar Cipher** - Break a simple substitution cipher
2. **Hash Cracking** - Crack password hashes using wordlists
3. **RSA Attack** - Exploit weak RSA implementation
4. **Block Cipher Mode Attacks** - Exploit ECB mode patterns
5. **Padding Oracle Attack** - Decrypt messages using padding errors

## Requirements

- Python 3
- hashcat or john (for hash cracking)
- OpenSSL
- Python libraries: pycryptodome, gmpy2

## Setup

Install dependencies:

```bash
pip install pycryptodome gmpy2
```

## Structure

```
crypto/
├── README.md
├── challenge1_caesar.py
├── challenge2_hash_cracking.py
├── challenge3_rsa_attack.py
├── challenge4_ecb_mode.py
└── challenge5_padding_oracle.py
```

## Key Concepts

- Symmetric vs Asymmetric encryption
- Hash functions and their properties
- Common cipher modes (ECB, CBC, CTR, GCM)
- Public key cryptography basics
- Side-channel attacks

Decrypt your way to freedom! 🔓
