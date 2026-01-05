/*
 * Cat-astrophic Security - Challenge 2: Format String Vulnerability
 *
 * VULNERABILITY: Uncontrolled format string
 * GOAL: Use format string to read the secret value from the stack
 *
 * INTENTIONALLY VULNERABLE - Educational purposes only!
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define SECRET 0xCAFEBABE

void print_banner() {
    printf("\n");
    printf("  /\\_/\\  \n");
    printf(" ( ^.^ ) \n");
    printf("  > ^ <  \n");
    printf(" /|   |\\ \n");
    printf("(_|   |_)\n");
    printf("\n");
}

void vulnerable_function() {
    char input[100];
    unsigned int secret = SECRET;

    printf("╔════════════════════════════════════════════╗\n");
    printf("║   🐱 Cat Cafe Feedback System 🐱         ║\n");
    printf("╚════════════════════════════════════════════╝\n");
    printf("\n");
    printf("Challenge 2: Format String Vulnerability\n");
    printf("\n");
    printf("There's a secret value on the stack: 0x%08X\n", secret);
    printf("Can you leak it using a format string bug?\n");
    printf("\n");
    printf("Hint: Try entering %%x or %%p to read stack values\n");
    printf("      Example: %%08x.%%08x.%%08x.%%08x\n");
    printf("\n");

    printf("Enter your feedback: ");
    fflush(stdout);

    if (fgets(input, sizeof(input), stdin) == NULL) {
        return;
    }

    input[strcspn(input, "\n")] = 0;

    printf("\n");
    printf("Your feedback: ");

    // VULNERABLE: User input directly as format string!
    printf(input);
    printf("\n\n");

    // Check if they found the secret
    if (strstr(input, "cafebabe") || strstr(input, "CAFEBABE")) {
        printf("╔════════════════════════════════════════════╗\n");
        printf("║  🎉 SUCCESS! Format String Exploited!    ║\n");
        printf("╚════════════════════════════════════════════╝\n");
        printf("\n");
        printf("🐱 You've successfully leaked the secret value!\n");
        printf("\n");
        printf("Your flag: FLAG{f0rm4t_str1ng_l34k}\n");
        printf("\n");
        printf("Code fragment: -ARY\n");
        printf("\n");
    } else {
        printf("💡 Tip: Use %%08x to read 32-bit values from the stack\n");
        printf("        The secret is somewhere in memory!\n");
        printf("\n");
    }
}

int main() {
    print_banner();

    setvbuf(stdout, NULL, _IONBF, 0);
    setvbuf(stdin, NULL, _IONBF, 0);

    vulnerable_function();

    return 0;
}
