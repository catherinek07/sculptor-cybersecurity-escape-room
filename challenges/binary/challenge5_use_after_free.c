/*
 * Cat-astrophic Security - Challenge 5: Use-After-Free
 *
 * VULNERABILITY: Using freed memory
 * GOAL: Exploit use-after-free to gain admin access
 *
 * INTENTIONALLY VULNERABLE - Educational purposes only!
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct {
    char name[32];
    int is_admin;
    void (*print_info)();
} Cat;

void print_banner() {
    printf("\n");
    printf("  /\\_/\\  \n");
    printf(" ( o.o ) \n");
    printf("  > ^ <  \n");
    printf(" /|   |\\ \n");
    printf("(_|   |_)\n");
    printf("\n");
}

void regular_print(Cat *c) {
    printf("Cat: %s (Regular user)\n", c->name);
}

void admin_print(Cat *c) {
    printf("\n");
    printf("╔════════════════════════════════════════════╗\n");
    printf("║  🎉 SUCCESS! Use-After-Free Exploited!   ║\n");
    printf("╚════════════════════════════════════════════╝\n");
    printf("\n");
    printf("🐱 Cat: %s (ADMIN ACCESS GRANTED!)\n", c->name);
    printf("\n");
    printf("Your flag: FLAG{us3_4ft3r_fr33}\n");
    printf("\n");
    printf("Code fragment: -T\n");
    printf("\n");
}

int main() {
    print_banner();

    setvbuf(stdout, NULL, _IONBF, 0);
    setvbuf(stdin, NULL, _IONBF, 0);

    Cat *cat1, *cat2;

    printf("╔════════════════════════════════════════════╗\n");
    printf("║   🐱 Cat Cafe User Management 🐱         ║\n");
    printf("╚════════════════════════════════════════════╝\n");
    printf("\n");
    printf("Challenge 5: Use-After-Free\n");
    printf("\n");

    // Allocate first cat
    printf("[+] Allocating cat1...\n");
    cat1 = (Cat *)malloc(sizeof(Cat));
    strcpy(cat1->name, "Whiskers");
    cat1->is_admin = 0;
    cat1->print_info = (void (*)())regular_print;

    printf("[+] Cat1: %p\n", cat1);
    printf("[+] Cat1->print_info: %p\n", cat1->print_info);
    printf("[+] admin_print function: %p\n", admin_print);
    printf("\n");

    // Free cat1
    printf("[+] Freeing cat1...\n");
    free(cat1);
    printf("\n");

    // Allocate cat2 (might reuse cat1's memory!)
    printf("[+] Enter new cat name: ");
    char input[100];
    if (fgets(input, sizeof(input), stdin) == NULL) {
        return 1;
    }
    input[strcspn(input, "\n")] = 0;

    cat2 = (Cat *)malloc(sizeof(Cat));
    strcpy(cat2->name, input);
    cat2->is_admin = 1;
    cat2->print_info = (void (*)())admin_print;

    printf("[+] Cat2: %p\n", cat2);
    printf("\n");

    // VULNERABLE: Using cat1 after free!
    printf("[+] Calling cat1->print_info() after free...\n");
    printf("\n");

    if (cat1->print_info == admin_print) {
        printf("💡 The memory was reused! cat1 now points to admin!\n");
        cat1->print_info(cat1);
    } else {
        printf("🐱 Cat1 after free: %s\n", cat1->name);
        if (cat1->is_admin) {
            printf("✓ Admin flag is set!\n");
            admin_print(cat1);
        } else {
            printf("❌ Not admin yet. The memory might not have been reused.\n");
            printf("\n");
            printf("💡 Tip: In a real exploit, you control what data fills the freed memory.\n");
            printf("        Since cat2 likely reused cat1's memory, cat1 now has admin access!\n");
            printf("\n");
            // Let's check anyway
            if (cat2 == cat1) {
                printf("✓ Same address! Memory was reused!\n");
                admin_print(cat2);
            }
        }
    }

    printf("\n");
    free(cat2);

    return 0;
}
