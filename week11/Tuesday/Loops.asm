COMMENT \
	CIS130
	Week 11

	for (int i = 0; i < 10; i++) {
		cout << arr[i];
		i = 5;
	}

	so in assembly
	how do we do loops
	in general, we use a counter that starts at
	number of iterations and countdown to 0

	first, initialize the counter (ECX)
	do whatever you need to do that repeats "ECX" times

	at the end of that "block" of code
	LOOP back to the beginning of that loop area...
	LOOP instruction internally will decrement ECX
	you don't have to do that manually
\

.386
.model flat,stdcall
.stack 4096  ; bytes
.data

stuff DWORD 012345678h

array WORD 10,20,30

ExitProcess proto,dwExitCode:dword

.code

main proc

	; stuff DWORD 012345678h
	; if i want to move 5678 into eax
	; hex, 2 digits = 8 bits = 1 byte
	; this preserves what's in the
	; upper part of eax
	; mov ax, WORD PTR stuff

	; this deletes what's in
	; upper part of eax
	movzx eax, WORD PTR stuff
	; which is very different
	; than doing mov eax, stuff
	; which does something similar

	; if  want 1234, that is 2 bytes
	; again, because every 2 hex digits
	; are 1 byte
	mov ax, WORD PTR stuff + 2

	mov eax, -5
	mov ebx, 50
	add eax, ebx
	inc eax
	mov eax, 1
	dec eax

	; indirect addressing
	mov eax, stuff ;12345678h

	mov ebx, OFFSET stuff ; moves address (32 bits)

	mov ecx, [ebx]	; <--- deference using [ ]

	; old way of adding stuff in array in previous lab
	mov ax, array
	add ax, array+2
	add ax, array+4

	; "new" way
	; using some of the new stuff we learned
	mov ebx, OFFSET array
	; yes - we're adding 16 bit values
	; but addresses are always 32 bits
	; so the address is moved into a 32 bit register

	mov eax, 0			; clear the values in eax
	xor eax, eax		; clear the values
	mov ax, [ebx]		; similar to mov ax, array
	add ax, [ebx + 2]	; this works fine
	add ax, [ebx + 4]	; this works fine

	; yet another version
	mov eax, 0			; clear the values in eax
	xor eax, eax		; clear the values
	mov ax, [ebx]		; similar to mov ax, array
	add ebx, 2
	add ax, [ebx]		; similar to add ax, array + 2
	add ebx, 2
	add ax, [ebx]		; similar to add ax, array + 4
	add ebx, 2

	; this version is copy/paste
	; will lend itself well to future loops

		; yet another version
	mov eax, 0			; clear the values in eax
	xor eax, eax		; clear the values
	mov ax, [ebx]		; similar to mov ax, array
	add ebx, TYPE array
	add ax, [ebx]		; similar to add ax, array + 2
	add ebx, TYPE array
	add ax, [ebx]		; similar to add ax, array + 4
	add ebx, TYPE array

	; yet another version
	; similar, but more mirrors
	; how we do things in higher level
	; aka - using an index
	mov eax, 0			; clear the values in eax
	xor eax, eax		; clear the values
	mov ecx, 0
	mov ax, [array + ecx]		; similar to mov ax, array
	add ecx, TYPE array
	add ax, [array + ecx]		; similar to add ax, array
	add ecx, TYPE array
	add ax, [array + ecx]		; similar to add ax, array
	add ecx, TYPE array

	; yet another version
	; last step i promise
	mov eax, 0			; clear the values in eax
	xor eax, eax		; clear the values
	mov ecx, 0
	mov ax, [array + ecx * TYPE array]		; similar to mov ax, array
	inc ecx
	add ax, [array + ecx * TYPE array]		; similar to add ax, array

	; unconditional jump
	LINE119: mov eax, 0			; clear the values in eax
	xor eax, eax		; clear the values
	mov ecx, 0
	mov ax, [array + ecx * TYPE array]		; similar to mov ax, array
	inc ecx
	add ax, [array + ecx * TYPE array]		; similar to add ax, array

	; JMP LINE119 ; <-- uncomment this for unfinite loop

	; LOOPS
	LINE129: mov eax, 0			; clear the values in eax
	xor eax, eax		; clear the values
	mov ecx, 0
	mov ax, [array + ecx * TYPE array]		; similar to mov ax, array
	inc ecx
	add ax, [array + ecx * TYPE array]		; similar to add ax, array

	LOOP LINE129

	xor eax, eax

	invoke ExitProcess,0
main endp
end main
