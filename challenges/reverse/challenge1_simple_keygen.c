/*
 * Cat-astrophic Security - Reverse Engineering Challenge 1: Simple Keygen
 *
 * GOAL: Reverse engineer the key validation algorithm
 * Create a keygen or find a valid key
 *
 * Educational purposes only!
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void print_banner() {
    printf("\n");
    printf("  /\\_/\\  \n");
    printf(" ( o.o ) \n");
    printf("  > ^ <  \n");
    printf(" /|   |\\ \n");
    printf("(_|   |_)\n");
    printf("\n");
}

int check_key(const char *key) {
    // Simple algorithm: key must be 16 chars
    // Sum of ASCII values must equal 1337
    // Must start with "CAT-"

    if (strlen(key) != 16) {
        return 0;
    }

    if (strncmp(key, "CAT-", 4) != 0) {
        return 0;
    }

    int sum = 0;
    for (int i = 0; i < 16; i++) {
        sum += (unsigned char)key[i];
    }

    if (sum == 1337) {
        return 1;
    }

    return 0;
}

int main() {
    char key[100];

    print_banner();

    printf("╔═══════════════════════════════════════════╗\n");
    printf("║   🐱 Cat Cafe Software Activation 🐱    ║\n");
    printf("╚═══════════════════════════════════════════╝\n");
    printf("\n");
    printf("Reverse Engineering Challenge 1: Simple Keygen\n");
    printf("\n");
    printf("Please enter your activation key: ");
    fflush(stdout);

    if (fgets(key, sizeof(key), stdin) == NULL) {
        return 1;
    }

    key[strcspn(key, "\n")] = 0;

    if (check_key(key)) {
        printf("\n");
        printf("╔═══════════════════════════════════════════╗\n");
        printf("║  🎉 SUCCESS! Valid activation key!      ║\n");
        printf("╚═══════════════════════════════════════════╝\n");
        printf("\n");
        printf("🐱 Congratulations! You've reverse engineered the keygen!\n");
        printf("\n");
        printf("Your flag: FLAG{k3yg3n_m4st3r}\n");
        printf("\n");
        printf("Code fragment: REV\n");
        printf("\n");
    } else {
        printf("\n");
        printf("❌ Invalid activation key!\n");
        printf("\n");
        printf("💡 Hints:\n");
        printf("  • Disassemble this binary with: objdump -d challenge1\n");
        printf("  • Or use Ghidra/IDA for decompilation\n");
        printf("  • Look for the check_key function\n");
        printf("  • Find the validation algorithm\n");
        printf("\n");
        printf("Algorithm hints (without spoiling):\n");
        printf("  • Key length: ? characters\n");
        printf("  • Starts with: ???-\n");
        printf("  • Sum of ASCII values: ?????\n");
        printf("\n");
    }

    return 0;
}
