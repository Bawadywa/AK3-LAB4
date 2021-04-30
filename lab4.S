.global lab4
.syntax unified

#define X1 #-17
#define X2 #12
#define X3 #17
#define X4 #3

lab4:
	push {lr}
	bl task1
	bl task2
	pop {pc}

task1:
	push {lr}
	mov r0, X1
	mov r1, #0xFFFFFFFF

	mov r2, X2
	mov r3, #0

	mov r4, X3
	mov r5, #0

	mov r6, X4
	mov r7, #0

	// calc
	adds r0, r2
	adc r1, r3

	subs r0, #1
	sbc r1, #0
	
	lsls r0, #1	//	*2
	lsl r1, #1
	adc r1, #0
	

	lsls r0, #1	//	*4
	lsl r1, #1
	adc r1, #0


	lsls r0, #1	//	*8
	lsl r1, #1
	adc r1, #0


	lsls r0, #1	//	*16
	lsl r1, #1
	adc r1, #0



	sub r4, r6	//	(x3-x4)/2
	sub r5, r7
	lsrs r4, #1
	bcc branch5
	rrx r5, r5
	b branch6
branch5:
	asr r5, #1
branch6:

	and r0, r4
	and r1, r5

	
	bl check_result
	pop {pc}
	


// correction
check_result:
	push {lr}
	bvc step2
	lsrs r0, #1
	rrx r1, r1
step2:
	orrs r0, #0	// update Z flag
	bne step4
	
// step 3
	mov r0, #0b10000000011000
	           
	lsl r0, #18
step4:
	mov r8, #0b10000000011000
	adds r1, r8

// step 5
	and r9, r1, #0x80000000
	beq marker1
	and r9, r1, #0x40000000
	beq normalize
	b step7

marker1:
	and r1, r1, #0x40000000
	beq step7
	
normalize:
	lsrs r0, #1
	rrx r1, r1
step7:
	bvc end_check_result
	lsrs r0, #1
	rrx r1, r1

end_check_result:
	pop {pc}

task2:
	push {lr}

	// init regs
	mov r0, #8
	mov r1, #2
	mov r2, #22
	mov r3, #15

prog_1:
	add r0, r2
	add r1, r0
	
p1:
	and r1, r2
	movs r3, r1
	beq p2
	
	sub r3, #5
	
	mov r3, #1
	lsrs r3, #1
	
	b p3
	
p2:
	mov r2, #1
	lsrs r2, #1
	b p3
	
p3:
	bl prog_2
	
	bcc p1
	
	add r2, #8
	mov r3, r2
	
	pop {pc}

prog_2:
	push {lr}

p4:
	mov r2, 50
	subs r2, 40
	bl prog_3
	
	bmi p5
	
	add r1, r2
	b p5
	
p5:
	mov r1, #5
	mov r2, #5
	
	subs r1, r2
	bne p4
	
	and r2, r1
	add r2, 15
	pop {pc}

prog_3:
	push {lr}
	mov r1, #25
	mov r3, #48
	pop {pc}

