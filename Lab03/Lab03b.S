.section .text
.global Lab03b

Lab03b:
	ADRP X1, UIN			//gets page address of UIN into X1
	ADD X1, X1, :lo12:UIN	//adds the page offset of UIN into X1
	LDUR X10, [X1, #0]		//loads UIN into X10
	MOVZ X2, #10			//holds the value of the loop condition in X2
	MOVZ X3, #0				//initializes i to 0 in X3
	SUB X4, X2, X3			//initial loop condition (10 - i) (X2 - X3)

	Loop: CBZ X4, End		//if 10 - i == 0, branch to end
	SUB X10, X10, #1			//UIN = UIN - 1
	ADD X3, X3, #1			// i = i + 1
	SUB X4, X2, X3			//X4 = 10 - i
	B Loop					//branches back to the start of the loop

	End: STUR X10, [X1, #0]	//stores the new value of UIN at the address where it was initialized
	BR X30					//branch back to the program

.section .data
	UIN: .quad 0x21			//8 + 2 + 4 + 6 + 6 + 7 = 33 == 21_hex
