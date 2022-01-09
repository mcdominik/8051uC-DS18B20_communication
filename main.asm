ORG 	0000h 
mov	p2,#10111111b
mov	p1,#00111111b
mov	p3,#00111111b
clr p0.6
clr p0.7
clr p0.5
ljmp 	1000h
ORG 	1000h
repeat:
	clr 	p0.0
	setb 	p0.0
	mov 	a,#0AAh
	mov 	r0,#0d
	lcall	START
	ljmp 	repeat
START:
	lcall 	f_send
	lcall 	f_read
	lcall 	f_display
	ret

f_send:
	inc 	r0
	clr 	p0.1
	rrc 	a
	mov 	p0.2,c
	setb 	p0.1
	cjne 	r0,#8d,f_wyslij
	ret	
f_read:
clr 	a
mov 	r0,#0d
times_8:	
inc 	r0
clr 	p0.1
mov 	c,p0.2
rrc 	a
setb 	p0.1
cjne 	r0,#08d,times_8
mov 	r6,a
mov 	a,#0d
clr 	p0.1
mov 	c,p0.2
rlc 	a
setb 	p0.1
mov 	r7,a
clr	p0.0
ret
f_display:
	mov a,r7
	cjne a,#0d,bridge
	
				;posivite
	clr p0.6
	mov a,r6  
	rrc a
	jnc calkowita_plus
	dec a
	mov	p3,#01101101b
	ljmp ustaw_0_plus
	calkowita_plus:
	mov	p3,#00111111b


ustaw_0_plus:
	mov b,#100d
	div ab
	
	check_zeroS:				;handles display
	cjne	a,#0d,check_oneS
	clr p0.7
	clr p0.5
	clr p0.6
	ljmp	ustawione
check_oneS:
	cjne	a,#1d,ustawione
	setb p0.7
	setb p0.5
	clr p0.6
	ljmp	ustawione
ustawione:
	mov a,b

	mov b,#10d
	div ab
	
	check_zero_plus:				;handles display
	cjne	a,#0d,check_one_plus
	mov	p1,#00111111b
	ljmp	dziesiatki_plus
check_one_plus:
	cjne	a,#1d,check_two_plus
	mov	p1,#00000110b
	ljmp	dziesiatki_plus
check_two_plus:
	cjne	a,#2d,check_3_plus
	mov	p1,#01011011b
	ljmp	dziesiatki_plus
check_3_plus:
	cjne	a,#3d,check_4_plus
	mov	p1,#01001111b
	ljmp	dziesiatki_plus
check_4_plus:
	cjne	a,#4d,check_5_plus
	mov	p1,#01100110b
	ljmp	dziesiatki_plus
check_5_plus:
	cjne	a,#5d,check_6_plus
	mov	p1,#01101101b
	ljmp	dziesiatki_plus
check_6_plus:
	cjne	a,#6d,check_7_plus
	mov	p1,#01111101b
	ljmp	dziesiatki_plus
check_7_plus:
	cjne	a,#7d,check_8_plus
	mov	p1,#00000111b
	ljmp	dziesiatki_plus

bridge:				;unknown
mov a,r7
	cjne a,#0d,negative
	
check_8_plus:
	cjne	a,#8d,check_9_plus
	mov	p1,#01111111b
	ljmp	dziesiatki_plus
check_9_plus:
	mov	p1,#01101111b


dziesiatki_plus:
	mov a,b
check_zeroJ_plus:
	cjne	a,#0d,check_oneJ_plus
	mov	p2,#10111111b
	ljmp	done
check_oneJ_plus:
	cjne	a,#1d,check_twoJ_plus
	mov	p2,#10000110b
	ljmp	done
check_twoJ_plus:
	cjne	a,#2d,check_3j_plus
	mov	p2,#11011011b
	ljmp	done
check_3j_plus:
	cjne	A,#3d,check_4j_plus
	mov	p2,#11001111b
	ljmp	done
check_4j_plus:
	cjne	A,#4d,check_5j_plus
	mov	p2,#11100110b
	ljmp	done
check_5j_plus:
	cjne	A,#5d,check_6j_plus
	mov	p2,#11101101b
	ljmp	done
check_6j_plus:
	cjne	A,#6d,check_7j_plus
	mov	p2,#11111101b
	ljmp	done
check_7j_plus:
	cjne	A,#7d,check_8j_plus
	mov	p2,#10000111b
	ljmp	done
check_8j_plus:
	cjne	A,#8d,check_9j_plus
	mov	p2,#11111111b
	ljmp	done
check_9j_plus:
	mov	p2,#11101111b
ljmp done
negative:	
	mov	p0,#01000000b
	mov a,r6  
	cpl a   
	rrc a
	inc a
	jc calkowita
	dec a
	mov	p3,#01101101b
	ljmp ustaw_0
	calkowita:
	mov	p3,#00111111b
ustaw_0:
	mov b,#10d
	div ab
	
	check_zero:				;handles display
	cjne	a,#0d,check_one
	mov	p1,#00000000b
	ljmp	dziesiatki
check_one:
	cjne	a,#1d,check_two
	mov	p1,#00000110b
	ljmp	dziesiatki
check_two:
	cjne	a,#2d,check_3
	mov	p1,#01011011b
	ljmp	dziesiatki
check_3:
	cjne	a,#3d,check_4
	mov	p1,#01001111b
	ljmp	dziesiatki
check_4:
	cjne	a,#4d,check_5
	mov	p1,#01100110b
	ljmp	dziesiatki
check_5:
	cjne	a,#5d,check_6
	mov	p1,#01101101b
	ljmp	dziesiatki
check_6:
	cjne	a,#6d,check_7
	mov	p1,#01111101b
	ljmp	dziesiatki
check_7:
	cjne	a,#7d,check_8
	mov	p1,#00000111b
	ljmp	dziesiatki
check_8:
	cjne	a,#8d,check_9
	mov	p1,#01111111b
	ljmp	dziesiatki
check_9:
	mov	p1,#01101111b
	
dziesiatki:
	mov a,b
check_zeroJ:
	cjne	a,#0d,check_oneJ
	mov	p2,#10111111b
	ljmp	done
check_oneJ:
	cjne	a,#1d,check_twoJ
	mov	p2,#10000110b
	ljmp	done
check_twoJ:
	cjne	a,#2d,check_3j
	mov	p2,#11011011b
	ljmp	done
check_3j:
	cjne	A,#3d,check_4j
	mov	p2,#11001111b
	ljmp	done
check_4j:
	cjne	A,#4d,check_5j
	mov	p2,#11100110b
	ljmp	done
check_5j:
	cjne	A,#5d,check_6j
	mov	p2,#11101101b
	ljmp	done
check_6j:
	cjne	A,#6d,check_7j
	mov	p2,#11111101b
	ljmp	done
check_7j:
	cjne	A,#7d,check_8j
	mov	p2,#10000111b
	ljmp	done
check_8j:
	cjne	A,#8d,check_9j
	mov	p2,#11111111b
	ljmp	done
check_9j:
	mov	p2,#11101111b
done:	
ret
END
