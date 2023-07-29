* Senior Dads Microdemo! (128 bytes)
; This is actually a bit of a challenge!

; (Demo originally released on 20 January 1998.
;
;  This dates from when there was a fashion for 128 byte demos on the Atari platforms.
;  This just blats stuff onto a true-colour screen, changing the value blatted so that 
;  it changes colour over time. You have to run this in true-colour lo-res mode, as there 
;  wasn't space for codce to change to ture-colour mode! You also have to reset the machine
;  to exit the demo, as there wasn't space for code to exit the demo either! 
;
;  You'll see that it uses funky 68030 offsetting instructions to do the blatting, so if 
;  you're assembling this using Vasm, make sure you use the -m68030 option to assemble it.
;
;  If you're wondering why a '128 byte' demo is actually 144 bytes, it's because of the
;  Atari TOS program header at the start of the file. The rules of 'size' demo competitions 
;  are generally that the size of the demo does not include the size of the program header, 
;  so as long as the code itself is 128 bytes, it's a 128 byte demo.}

 * ## Assembly information ##
 * Assembly format: Devpac 3 (VASM compatible)
 * Target processor: Motorola 68030
 * Exectuable format: Atari TOS .PRG
 * Minimum hardware: Atari Falcon 030 with 4MB RAM


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
main
	pea	0.l
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
