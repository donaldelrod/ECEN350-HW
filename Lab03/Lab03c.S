.section .text
.globl Lab03c

Lab03c:
	ADRP X1, my_array				//gets page address of my_array into X1
	ADD X1, X1, :lo12:my_array		//adds page offset
	ADRP X2, init_val				//gets page address of init_val into X2
	ADD X2, X2, :lo12:init_val		//adds page offset
	LDUR X3, [X2, 0]				//loads initial_value into X3, X3 = j
	MOVZ X4, #10					//sets loop counter into X4
	ORR X5, XZR, XZR				//sets i = 0 into X5
	SUB X6, X4, X5					//sets loop initial condition

	Loop: CBZ X6, Exit
	LSL X7, X5, 3					//gets address offset of my_array for my_array[ i ] into X7
	MOVZ X9, 0
	ADD X9, X1, X7
	STUR X3, [X9, 0]				//stores the value of j into my_array[ i ]
	ADD X3, X3, 1					// j = j + 1
	ADD X5, X5, 1					// i = i + 1
	SUB X6, X4, X5					// checks if the loop has run the right amount of times
	b Loop							//branches to the beginning of the loop

	Exit: BR x30					//returns to the program that called it

.section .data
	my_array: .space 80
	init_val: .byte 8
