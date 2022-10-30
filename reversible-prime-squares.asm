# AUTHOR: Poulo Sebolai
# DATE: 10 OCTOBER 2022
# PROGRAM NAME: reversible-prime-squares.asm

# FUNCTION: The program determines and prints out the first ten reversible prime squares

.data #data segment
message: .asciiz "The following are the first 10 reversible prime squares: "
space: .asciiz " "
.text #text segment

main:

# a call for printing out a string message
li $v0, 4
la $a0, message
syscall

li $s3, 4000	# $s3 = 4000, where 4000 is the limit of iteration
li $t0, 2		# counter is initialised to 2, ie, i = 2

#copy the value of $t0 into $8 
move $t8, $t0
	
mainLoop: beq $t0, $s3, exit
	jal isprime
	beq $s0, $zero, label1
	beq $s0, $zero, label2
	
	addi $t0, $t0, 1	# ocuter increment
j mainLoop	# jump back to the mainLoop

#a call for program termination
exit:li $v0, 10
	syscall

#instructions and labels inside the isprime label will determine whether a certain integer is prime
isprime:	
	li $t1, 2	#load 2 into register t1, etc, j=2
		loop1:
			div $t2, $t0, $t1	#divide t0 with t1 and return the remainder
			mfhi $t3
			beq $t3, $zero, ifstatement
			addi $t1, $t1, 1
			j loop1


#the section of code runs to label true if the number is prime and false if it is not
ifstatement:beq $t0, $t1, True
			j false
      
#The true label stores 0 in register s0 if the number is prime
True:li $s0, 0
	j backtomain

#store 1 in $s0 if the number is not prime
false:li $s0, 1
	j backtomain


reversenum:# instructions and labels in reversenum will reverse the number
	li $s1, 10
	li $t1, 0	# reverse = 0
	loop2: 
		beq $t0, $zero, sqrt
		div $s0, $t0, $s1
		mfhi $t2	# remainder = square prime%10
		mul $t1, $t1, $s1
		add $t1, $t1, $t2
		div $t0, $t0, $s1
		j loop2
	
	
#implementation of reversed squre of a prime
sqrt:
	#move an integer in register t0 into float register f0 
	mtc1 $t1, $f0

	#convert an an integer in $f0, to float and store the value in $f1
	cvt.s.w $f1, $f0 #$f1=n

	#an assignment statement $f2=$f1
	li.s $f2, 0.0
	add.s $f2, $f2, $f1


	li $s1, 10

	li.s $f0, 2.0
	li $t1, 0
	loop:
		beq $t1, $s1, move2TR
		div.s $f3, $f1, $f2
		add.s $f2, $f2, $f3
		div.s $f2, $f2, $f0
		addi $t1, $t1, 1
	j loop


# definitons of instructions in label 1
label1: mul $t1, $t0, $t0
		li $t7, 0 #keep square constant
		add $t7, $t7, $t1
		
		j reversenum
		
#move float square root into register of integer and convert in to an integer
move2TR:cvt.w.s $f2, $f2
		mfc1 $t0, $f2
		j isprime

#check if the square root is an integer	
label2:	div $t4, $t1, $t0
		mfhi $t5
		beq $t5, $zero, checksqrt
		jr $ra
		
#check whether the square root of reverse num is not the same as that of num
checksqrt:beq $t0, $t8, backtomain
		blt $t7, $t1, printoutput
		
		
		
#the program jumps back to the next instruction in the main function
backtomain: jr $ra

#a call for printing out a square prime and its reverse
printoutput:li $v0, 1
			move $a0, $t7
			syscall
			
			li $v0, 4
			la $a0, space
			syscall
			
			li $v0, 1
			move $a0, $t1
			syscall
			
			j backtomain
			
