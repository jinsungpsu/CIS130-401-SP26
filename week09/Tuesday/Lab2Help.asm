COMMENT \
	CIS130
\

.386
.model flat,stdcall
.stack 4096  ; bytes
.data

; many different types
; focus on size, # of bits/bytes

; identifier type initial value
num1 BYTE 1
num2 SBYTE -1
num3 DWORD 1001b
num4 TBYTE 0FFFFh ; 1111 1111 1111 1111 
letter DWORD 'a' 
;allowed to do this, but doesn't really make sense
; because chars using ascii only need 8 bits
letter2 BYTE 'A'


; arrays

numbers BYTE 1,2,3,4,5

numbers2 DWORD 10,20,30,40

numbers3 TBYTE 0ffh, 011h, 022h

; lab 2 related code goes here
; first, create an array of 5 items!
; don't use QWORD or TBYTE, you won't be able to do this lab
; without help

lab2array DWORD 1,2,3,4,5



ExitProcess proto,dwExitCode:dword

.code

main proc
	; lab 2 help
	; move and add have similar rules
	; cannot have 2 memory operands
	; not allowed! add lab2array, num

	; if i ever want to add two items in memory
	; i need to move one of them into a register first

	mov eax, lab2array				; this moves the FIRST item in the array into EAX register
	add eax, lab2array+4			; +1 in this case is pointer arithmetic
									; when doin pointer arithmetic
									; the numbers are in BYTES
									; if using DWORD type
									; the offset would +4 (4 bytes or 32 bits)

	invoke ExitProcess,0
main endp
end main
