/*
 * Cat-astrophic Security - Reverse Engineering Challenge 3: Simple VM
 *
 * GOAL: Reverse engineer a simple virtual machine and its bytecode
 *
 * Educational purposes only!
 */

#include <stdio.h>
#include <stdint.h>
#include <string.h>

void print_banner() {
    printf("\n");
    printf("  /\\_/\\  \n");
    printf(" ( -.- ) \n");
    printf("  > ^ <  \n");
    printf(" /|   |\\ \n");
    printf("(_|   |_)\n");
    printf("\n");
}

// Simple stack-based VM
#define STACK_SIZE 256

typedef enum {
    OP_PUSH = 0x01,  // Push value to stack
    OP_ADD  = 0x02,  // Add top two values
    OP_SUB  = 0x03,  // Subtract
    OP_MUL  = 0x04,  // Multiply
    OP_CMP  = 0x05,  // Compare with input
    OP_HALT = 0xFF   // Stop execution
} Opcode;

int execute_vm(uint8_t *bytecode, int code_len, int input) {
    int stack[STACK_SIZE];
    int sp = 0;  // Stack pointer
    int pc = 0;  // Program counter

    while (pc < code_len) {
        uint8_t op = bytecode[pc++];

        switch (op) {
            case OP_PUSH:
                if (pc >= code_len) return 0;
                stack[sp++] = bytecode[pc++];
                break;

            case OP_ADD:
                if (sp < 2) return 0;
                stack[sp-2] = stack[sp-2] + stack[sp-1];
                sp--;
                break;

            case OP_SUB:
                if (sp < 2) return 0;
                stack[sp-2] = stack[sp-2] - stack[sp-1];
                sp--;
                break;

            case OP_MUL:
                if (sp < 2) return 0;
                stack[sp-2] = stack[sp-2] * stack[sp-1];
                sp--;
                break;

            case OP_CMP:
                if (sp < 1) return 0;
                return (stack[sp-1] == input);

            case OP_HALT:
                return 0;

            default:
                return 0;
        }
    }

    return 0;
}

int main() {
    char input_str[100];
    int input_num;

    print_banner();

    printf("╔═══════════════════════════════════════════╗\n");
    printf("║   🐱 Cat Cafe VM Challenge 🐱           ║\n");
    printf("╚═══════════════════════════════════════════╝\n");
    printf("\n");
    printf("Reverse Engineering Challenge 3: Virtual Machine\n");
    printf("\n");

    // Secret bytecode: PUSH 7, PUSH 6, MUL, PUSH 1, ADD, CMP
    // Result: 7 * 6 + 1 = 43
    uint8_t bytecode[] = {
        OP_PUSH, 7,
        OP_PUSH, 6,
        OP_MUL,
        OP_PUSH, 1,
        OP_ADD,
        OP_CMP
    };

    printf("This program runs a simple stack-based virtual machine.\n");
    printf("Find the magic number that makes it return true!\n");
    printf("\n");

    printf("Enter the magic number: ");
    fflush(stdout);

    if (fgets(input_str, sizeof(input_str), stdin) == NULL) {
        return 1;
    }

    input_num = atoi(input_str);

    if (execute_vm(bytecode, sizeof(bytecode), input_num)) {
        printf("\n");
        printf("╔═══════════════════════════════════════════╗\n");
        printf("║  🎉 SUCCESS! Correct magic number!      ║\n");
        printf("╚═══════════════════════════════════════════╝\n");
        printf("\n");
        printf("🐱 You've reverse engineered the VM bytecode!\n");
        printf("\n");
        printf("The magic number is: %d\n", input_num);
        printf("\n");
        printf("Your flag: FLAG{v1rtu4l_m4ch1n3}\n");
        printf("\n");
        printf("Code fragment: -E\n");
        printf("\n");
    } else {
        printf("\n");
        printf("❌ Wrong number!\n");
        printf("\n");
        printf("💡 Hints:\n");
        printf("  • Disassemble the binary to find the bytecode array\n");
        printf("  • Understand the VM instruction set:\n");
        printf("    PUSH (0x01) - Push value to stack\n");
        printf("    ADD  (0x02) - Add top two values\n");
        printf("    MUL  (0x04) - Multiply top two values\n");
        printf("    CMP  (0x05) - Compare stack top with input\n");
        printf("  • Trace through the bytecode execution\n");
        printf("  • Calculate what number the VM computes\n");
        printf("\n");
    }

    return 0;
}
