.section .text
.globl lab02c

lab02c:
	ADRP X3, hextable				//gets page address of hextable into X3
	ADD X3, X3, :lo12:hextable		//gets page offset of hextable into X3
	ADRP X5, result					//gets page address of result into X5
	ADD X5, X5, :lo12:result		//gets page offset of result into X5
	LSR X1, X0, 4					//get the upper 4 bits of X0 into X1
	ADD X2, X1, X3					//get address in hextable
	LDURB W4, [X2, 0]				//get character
	STURB W4, [X5, 0]				//stores character in result
	AND X1, X0, 0xf					//get lower 4 bits
	ADD X2, X3, X1					//get address in hextable
	LDURB W4, [X2, 0]				//get character
	STURB W4, [X5, 1]				//store character in result
	BR X30
.section .data
	hextable: .asciz "0123456789abcdef"
	msg1: .asciz "Your number in Hex is: "
	result: .byte 2
