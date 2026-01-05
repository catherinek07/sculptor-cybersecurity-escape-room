/*
 * Cat-astrophic Security - Challenge 3: Shellcode Execution
 *
 * VULNERABILITY: Buffer overflow + executable stack
 * GOAL: Execute shellcode to print the flag
 *
 * INTENTIONALLY VULNERABLE - Educational purposes only!
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void print_banner() {
    printf("\n");
    printf("  /\\_/\\  \n");
    printf(" ( -.- ) \n");
    printf("  > ^ <  \n");
    printf(" /|   |\\ \n");
    printf("(_|   |_)\n");
    printf("\n");
}

void secret_function() {
    printf("\n");
    printf("╔════════════════════════════════════════════╗\n");
    printf("║  🎉 SUCCESS! Shellcode Executed!         ║\n");
    printf("╚════════════════════════════════════════════╝\n");
    printf("\n");
    printf("🐱 You've successfully executed your shellcode!\n");
    printf("\n");
    printf("Your flag: FLAG{sh3llc0d3_3x3cut3d}\n");
    printf("\n");
    printf("Code fragment: -EXP\n");
    printf("\n");
}

void vulnerable_function() {
    char buffer[64];

    printf("╔════════════════════════════════════════════╗\n");
    printf("║   🐱 Cat Cafe Command System 🐱          ║\n");
    printf("╚════════════════════════════════════════════╝\n");
    printf("\n");
    printf("Challenge 3: Shellcode Execution\n");
    printf("\n");
    printf("The stack is executable (compiled with -z execstack)\n");
    printf("Buffer address: %p\n", buffer);
    printf("Secret function: %p\n", secret_function);
    printf("\n");
    printf("Goal: Overflow the buffer and redirect execution\n");
    printf("      to the secret_function!\n");
    printf("\n");
    printf("💡 Simple method: Overflow return address with secret_function\n");
    printf("   Advanced: Write and execute real shellcode!\n");
    printf("\n");

    printf("Enter command: ");
    fflush(stdout);

    // VULNERABLE: No bounds checking!
    gets(buffer);

    printf("\nCommand processed: %s\n", buffer);
}

int main() {
    print_banner();

    setvbuf(stdout, NULL, _IONBF, 0);
    setvbuf(stdin, NULL, _IONBF, 0);

    printf("For this challenge:\n");
    printf("1. Note the buffer address and secret_function address\n");
    printf("2. Create a payload to overwrite the return address\n");
    printf("3. Use Python to send the exploit:\n");
    printf("   python -c 'print(\"A\"*76 + \"\\xNN\\xNN\\xNN\\xNN\")' | ./challenge3\n");
    printf("\n");
    printf("Press Enter to continue...");
    getchar();

    vulnerable_function();

    printf("\n❌ Normal execution completed. Try overflowing!\n\n");

    return 0;
}
