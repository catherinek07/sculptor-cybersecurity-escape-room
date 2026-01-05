/*
 * Cat-astrophic Security - Reverse Engineering Challenge 2: Password Checker
 *
 * GOAL: Find the hardcoded password by reverse engineering
 *
 * Educational purposes only!
 */

#include <stdio.h>
#include <string.h>

void print_banner() {
    printf("\n");
    printf("  /\\_/\\  \n");
    printf(" ( ^.^ ) \n");
    printf("  > ^ <  \n");
    printf(" /|   |\\ \n");
    printf("(_|   |_)\n");
    printf("\n");
}

// Obfuscated password check
int verify_password(const char *input) {
    // Password is: "M30W_M30W_PURR"
    // Encoded as XOR with 0x42

    unsigned char encoded[] = {
        0x0f, 0x75, 0x6c, 0x25, 0x7f, 0x0f, 0x75, 0x6c,
        0x25, 0x7f, 0x12, 0x37, 0x20, 0x20
    };

    int len = sizeof(encoded);

    if (strlen(input) != len) {
        return 0;
    }

    for (int i = 0; i < len; i++) {
        if ((unsigned char)input[i] != (encoded[i] ^ 0x42)) {
            return 0;
        }
    }

    return 1;
}

int main() {
    char password[100];

    print_banner();

    printf("╔═══════════════════════════════════════════╗\n");
    printf("║   🐱 Cat Cafe Admin Portal 🐱           ║\n");
    printf("╚═══════════════════════════════════════════╝\n");
    printf("\n");
    printf("Reverse Engineering Challenge 2: Password Checker\n");
    printf("\n");
    printf("Enter the admin password: ");
    fflush(stdout);

    if (fgets(password, sizeof(password), stdin) == NULL) {
        return 1;
    }

    password[strcspn(password, "\n")] = 0;

    if (verify_password(password)) {
        printf("\n");
        printf("╔═══════════════════════════════════════════╗\n");
        printf("║  🎉 SUCCESS! Correct password!          ║\n");
        printf("╚═══════════════════════════════════════════╝\n");
        printf("\n");
        printf("🐱 Welcome, Admin!\n");
        printf("\n");
        printf("Your flag: FLAG{p4ssw0rd_f0und}\n");
        printf("\n");
        printf("Code fragment: -ERS\n");
        printf("\n");
    } else {
        printf("\n");
        printf("❌ Access Denied!\n");
        printf("\n");
        printf("💡 Hints:\n");
        printf("  • The password is hardcoded in the binary\n");
        printf("  • Use 'strings' command: strings challenge2\n");
        printf("  • Or disassemble with Ghidra/IDA\n");
        printf("  • Look for the verify_password function\n");
        printf("  • The password might be encoded/obfuscated\n");
        printf("\n");
    }

    return 0;
}
