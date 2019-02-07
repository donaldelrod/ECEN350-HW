// Test.S assembly test file, determine what this function is...

.globl test

test:

// make sure you replace Z with the first digit of your UIN

LSR X1, X0, #8  //computation 1, result is in $X1

LSL X2, X0, #8 //computation 2, result is in $X2

// check the content of $X1 and $X2

ADD X0, X1, X2

BR X30 // return from main ; return address stored in X30
