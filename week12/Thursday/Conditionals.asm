COMMENT \
	CIS130
\

.386
.model flat,stdcall
.stack 4096  ; bytes
.data


ExitProcess proto,dwExitCode:dword

.code

main proc

	MOV EAX, 99

	; check if it's even or odd
	AND EAX, 1	; in binary, decimal 1 is 0000000.... 0001

	; if EAX had an even value
	; ZR flag would be 1
	; if EAX had an odd value
	; ZR flag would be 0

	JZ ODD			; EAX was an odd value
	; if EAX was even... line 27 would NOT jump

	; this is similar to an IF/Else situation
	; only one of these ""blocks"" should
	; ever execute
	; we are putting "blocks" in quotes, because
	; there's no such thing as code blocks in assembly

EVEN:
	; this is the code that is executed if
	; EAX had an even value

	; if we don't do anything
	; BOTH EVEN and ODD "blocks" would get executed

	JMP AFTER
ODD:
	; this is the code that is executed if
	; eax had an odd value


AFTER:
	; some code that continues



BEGINNING_OF_PROGRAM:
	MOV EAX, 5
	CMP EAX, 5
	; 5 - 5 = 0
	; ZR = 1

	MOV EAX, 4
	CMP EAX, 5
	; 4 - 5 = -1
	; ZR = 0

	MOV AL, 01111111b
	ADD AL, 01111111b
	; CY, or Carry should be set
	; AKA, MSB will have a carry out

	JC BEGINNING_OF_PROGRAM

	invoke ExitProcess,0
main endp
end main
