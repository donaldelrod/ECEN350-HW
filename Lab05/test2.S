.section .text
.globl test2

test2:
	SUB X1, X0, X1
	ADRP X0, string
	ADD X0, X0, :lo12:string
	SUB SP, SP, 16
	STUR X30, [SP, 0]
	BL printf
	LDUR X30, [SP, 0]
	ADD SP, SP, 16
	BR X30

.section .data
	string: .asciz "Result of test2(6, 5) = %d\n"
