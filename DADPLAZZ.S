* Senior Dads Microdemo! (128 bytes)
; This is actually a bit of a challenge!

vidregs		equ	$ffff8200
vidlo		equ	$ffff820d

timer	equ	$468

;DEBUG
	IFND	DEBUG
	opt	d-		; No labels in final version
	ENDC	
	opt	p+,o+		; Code must be PC-relative

	bra.s	main
	dc.b	'dAdPlAz!'
main	pea	0.l
	move	#$20,-(sp)
	trap	#1

demo	

init	
	lea	screen(pc),a5
	lea	(320*2)(a5),a6
	move.l	a5,d0
	move.b	d0,vidlo.w
	lsr.w	#8,d0
	move.l	d0,vidregs.w
main_loop

	move.w	#(100*320)+(320),d6
copy_loop
	subq.w	#2,d6
	beq.s	end_copy
	move.w	(a5,d6.l*2),(a5,d6.l*8)
	move.w	(a5,d6.l*2),-4(a5,d6.l*8)
	move.w	(a5,d6.l*2),(a6,d6.l*8)
	move.w	(a5,d6.l*2),-4(a6,d6.l*8)
	move.w	timer.w,(a5,d6.l*2)
	bra.s	copy_loop

end_copy

	bra.s	main_loop

	bss
	cnop	0,4
screen
	ds.w	320*240
end_code
