* Senior Dads Microdemo! (128 bytes)
; This is actually a bit of a challenge!

; (Demo originally released on 20 January 1998.
;
;  This dates from when there 128 byte demos started to become popular on the Atari platforms.
;  This just blats values onto a true-colour screen, the value being the VBL clock, so 
;  the screen changes colour over time. You have to run this in true-colour lo-res mode, as there 
;  wasn't space for codce to change to true-colour mode! You also have to reset the machine
;  to exit the demo, as there wasn't space for code to exit the demo either! 
;
;  You'll see that it uses funky 68030 offsetting instructions to do the blatting, so if 
;  you're assembling this using Vasm, make sure you use the -m68030 option to assemble it.
;
;  If you're wondering why a '128 byte' demo program is actually 144 bytes, it's because of the
;  Atari TOS program header at the start of the file. The rules of 'size' demo competitions 
;  are generally that the size of the demo does not include the size of the program header, 
;  so as long as the code itself is 128 bytes, it's a 128 byte demo.)

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
	opt	d-						; No labels in final version
	ENDC	
	opt	p+,o+					; Code must be PC-relative

	bra.s	main
	dc.b	'dAdPlAz!'			; <-- Wonder if we *could* have changed graphics mode if we didn't include this?
main
	pea	0.l
	move	#$20,-(sp)
	trap	#1					; <-- Yeah!!!! Stuff the stack!!!! We don't need it anyway!!!!!

demo	

init	
	lea	screen(pc),a5			; <-- Hmmm... Did we really need to initialise a custom screen like this? 
	lea	(320*2)(a5),a6			;    Maybe could have just used the default screen, and saved enough bytes to 
	; ^^^^^^ What?! ^^			;    change graphics mode to true-colour mode?
	;        We're not using a6 anywhere in the code!
	move.b	d0,vidlo.w			
	lsr.w	#8,d0
	move.l	d0,vidregs.w
main_loop

	move.w	#(100*320)+(320),d6
copy_loop
	subq.w	#2,d6
	beq.s	end_copy
	move.w	(a5,d6.l*2),(a5,d6.l*8)			; <-- This is the funky 68030 offsetting stuff I was talking about!
	move.w	(a5,d6.l*2),-4(a5,d6.l*8)		;     If you know anything about true-colour mode, you'll see we're
	move.w	(a5,d6.l*2),(a6,d6.l*8)			;     copying a pixel to pixels around it, but each time we move onto
	move.w	(a5,d6.l*2),-4(a6,d6.l*8)		;     different pixel, until we've covered the whole screen.
	move.w	timer.w,(a5,d6.l*2)				; <-- Here we're placing the VBL clock value into the pixel we've 
	bra.s	copy_loop						;     just copied. This is what makes the screen change colour over time.

end_copy

	bra.s	main_loop

	bss
	cnop	0,4
screen
	ds.w	320*240
end_code
