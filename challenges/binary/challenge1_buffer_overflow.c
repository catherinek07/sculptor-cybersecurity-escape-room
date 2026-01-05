/*
 * Cat-astrophic Security - Challenge 1: Buffer Overflow
 *
 * VULNERABILITY: Classic stack-based buffer overflow
 * GOAL: Overflow the buffer to overwrite the 'access_granted' variable
 *
 * INTENTIONALLY VULNERABLE - Educational purposes only!
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

void print_flag() {
    printf("\n");
    printf("╔════════════════════════════════════════════╗\n");
    printf("║  🎉 SUCCESS! Buffer Overflow Exploited!  ║\n");
    printf("╚════════════════════════════════════════════╝\n");
    printf("\n");
    printf("🐱 Congratulations! You've successfully exploited\n");
    printf("   a buffer overflow vulnerability!\n");
    printf("\n");
    printf("Your flag: FLAG{buff3r_0v3rfl0w_c4t}\n");
    printf("\n");
    printf("Code fragment: BIN\n");
    printf("\n");
}

int check_password() {
    char buffer[16];           // Small buffer - vulnerable!
    int access_granted = 0;     // Target variable

    printf("╔════════════════════════════════════════════╗\n");
    printf("║   🐱 Cat Cafe Security System v1.0 🐱    ║\n");
    printf("╚════════════════════════════════════════════╝\n");
    printf("\n");
    printf("Challenge 1: Buffer Overflow\n");
    printf("\n");
    printf("The password buffer is only 16 bytes!\n");
    printf("Can you overflow it to set access_granted = 1?\n");
    printf("\n");
    printf("Hint: Try entering more than 16 characters\n");
    printf("      The variables are stored on the stack:\n");
    printf("      [buffer][access_granted]\n");
    printf("\n");

    printf("Enter password: ");
    fflush(stdout);

    // VULNERABLE: No bounds checking!
    gets(buffer);

    printf("\n");
    printf("Buffer contents: %s\n", buffer);
    printf("Access granted: %d\n", access_granted);
    printf("\n");

    if (access_granted != 0) {
        print_flag();
        return 1;
    } else {
        printf("❌ Access denied! Try overflowing the buffer.\n");
        printf("\n");
        printf("💡 Tip: The buffer is 16 bytes. Try 20+ characters\n");
        printf("        to overflow into access_granted!\n");
        printf("\n");
        return 0;
    }
}

int main() {
    print_banner();

    // Disable buffering for easier exploitation
    setvbuf(stdout, NULL, _IONBF, 0);
    setvbuf(stdin, NULL, _IONBF, 0);

    while (1) {
        if (check_password()) {
            break;
        }

        printf("Try again? (y/n): ");
        char choice = getchar();
        getchar(); // Consume newline

        if (choice != 'y' && choice != 'Y') {
            printf("\nGoodbye! 🐾\n\n");
            break;
        }
        printf("\n");
    }

    return 0;
}
