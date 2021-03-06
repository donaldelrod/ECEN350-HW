//.section .text
.globl lab04b
//n is passed to the function and stored in X0

lab04b:
    SUB SP, SP, 16 //make room for 2 more doublewords in stack pointer
    STUR X30, [SP, 8] //store current link register in stack pointer
    STUR X0, [SP, 0] //store current n in stack pointer 
    SUB X9, X0, 1 //checks if n-1 == 0 
    CBNZ X9, next_n //branches to next_n if it is not 
    MOVZ X1, 1 //sets X1 to 1 
    ADD SP, SP, 16 //removes the return address and current n from SP 
    BR X30
next_n:  
    SUB X0, X0, 1 //subtracts 1 from n
    BL lab04b         //returns to factorial
    LDUR X1, [SP, 0] //loads the old value of n 
    BL my_mul //multiplies the numbers recursively
    LDUR X30, [SP, 8] //loads the previous link register
    ADD SP, SP, 16 //pops 2 items off the stack 
    BR X30
//my_mul:
//    MUL X0, X0, X1 //multiplies n and n-1 into X1
//    BR X30 //returns to caller program
