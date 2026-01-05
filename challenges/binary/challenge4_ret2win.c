/*
 * Cat-astrophic Security - Challenge 4: Return-to-Win
 *
 * VULNERABILITY: Buffer overflow to redirect to win function
 * GOAL: Call the win() function by overflowing
 *
 * INTENTIONALLY VULNERABLE - Educational purposes only!
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void print_banner() {
    printf("\n");
    printf("  /\\_/\\  \n");
    printf(" ( ^.^ ) \n");
    printf("  > ^ <  \n");
    printf(" /|   |\\ \n");
    printf("(_|   |_)\n");
    printf("\n");
}

void win() {
    printf("\n");
    printf("╔════════════════════════════════════════════╗\n");
    printf("║  🎉 SUCCESS! You reached the win()!      ║\n");
    printf("╚════════════════════════════════════════════╝\n");
    printf("\n");
    printf("🐱 Perfect! You've mastered return address control!\n");
    printf("\n");
    printf("Your flag: FLAG{r3t2w1n_m4st3r}\n");
    printf("\n");
    printf("Code fragment: -LO1\n");
    printf("\n");
}

void never_called() {
    printf("This function should never be called normally!\n");
}

void vulnerable() {
    char buffer[32];

    printf("╔════════════════════════════════════════════╗\n");
    printf("║   🐱 Cat Cafe Access System 🐱           ║\n");
    printf("╚════════════════════════════════════════════╝\n");
    printf("\n");
    printf("Challenge 4: Return-to-Win (ret2win)\n");
    printf("\n");
    printf("There's a win() function that's never called normally.\n");
    printf("Can you hijack the return address to call it?\n");
    printf("\n");
    printf("Important addresses:\n");
    printf("  Buffer: %p\n", buffer);
    printf("  win():  %p\n", win);
    printf("\n");
    printf("💡 Offset to return address: 32 (buffer) + padding\n");
    printf("   Typically: 32 bytes buffer + saved ebp (4 bytes) = 36 bytes offset\n");
    printf("\n");

    printf("Enter your name: ");
    fflush(stdout);

    // VULNERABLE!
    gets(buffer);

    printf("\nWelcome, %s!\n", buffer);
}

int main() {
    print_banner();

    setvbuf(stdout, NULL, _IONBF, 0);
    setvbuf(stdin, NULL, _IONBF, 0);

    printf("Exploit method:\n");
    printf("  python3 -c 'import sys; sys.stdout.buffer.write(b\"A\"*44 + b\"\\xAD\\xDR\\xES\\xS\")' | ./challenge4\n");
    printf("  (Replace \\xAD\\xDR\\xES\\xS with the actual win() address in little-endian)\n");
    printf("\n");
    printf("Press Enter to start...");
    getchar();

    vulnerable();

    printf("\n✓ Normal execution path\n\n");

    return 0;
}
