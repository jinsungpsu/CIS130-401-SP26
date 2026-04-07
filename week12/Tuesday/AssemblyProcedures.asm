COMMENT \
	CIS130
\

.386
.model flat,stdcall
.stack 4096  ; bytes
.data

	myvar DWORD ?

	someval DWORD 99

ExitProcess proto,dwExitCode:dword

.code
	

main proc

	add eax, 10
	add ebx, (10+90 * 3)


	PUSH 1				; implied destination
						; put it into the runtime stack
						; even more specifically
						; put it on the "top" of the
						; runtime stack
						; currently runtime stack status is:
						; top
						; 1
						; bottom
	PUSH 99
						; currently runtime stack status is:
						; top
						; 99
						; 1
						; bottom


	PUSH someval
						; currently runtime stack status is:
						; top
						; 99
						; 99
						; 1
						; bottom


	mov ecx, 105


	PUSH ecx
						; currently runtime stack status is:
						; top
						; 105
						; 99
						; 99
						; 1
						; bottom

	; pop needs a destination

	POP eax

	call addNums
		; does two things
		; 1) make sure i save where i need to go 
		; next AFTER i finish this function
		; 2) change the program counter NOT to go to
		; the next line, but go into the function
		; instead

	POP eax



	; operand cannot immediate address aka constant
	mov myvar, 1		; explicit destination

	invoke ExitProcess,0
main endp

; new procedure must be inside of "end main"
; but outside of main procedure
; so after endp
; how do we define new procedures
; name of procedure followed by PROC
; ... bunch of code
; followed by name of procedure and ENDP

addNums PROC


	RET ; must have this
		; or your program will break
		; and you'll be confused
		; this restores the top of the stack to EIP
		; makes sure it goes back to wherever
		; this function was called from
		; could be main
		; could be another funciont
addNums ENDP

end main
