.globl test

test:
	MOVZ X1, #10
	ADD X0, XZR, XZR

loop:
	CBZ X1, finish
	ADD X0, X0, X1
	SUB X1, X1, #1
	B loop

finish:
	ADD X0, X0, 100
	BR X30
