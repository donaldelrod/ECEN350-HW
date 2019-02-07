/* main.c simple program to test assembler program */

//#include <stdio.h>

extern long long int test(long long int a, long long int b);
extern void Lab03b();
extern void Lab03c();
int main(void) {
    //long long int a = test(3, 5);
    //Lab03b();
	Lab03c();
    //printf("Result of test(3, 5) = %ld\n", a);
    return 0;
}
