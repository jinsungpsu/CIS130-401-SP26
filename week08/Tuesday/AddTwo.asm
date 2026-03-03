; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example

.386
.model flat,stdcall
.stack 4096
.data
; in the lab computers, the first address assigned is: 0x00404000
num dword (1+1)

name byte 'hello world'
name2 byte "hello world"
char1 byte 'a'
char2 byte "A"

ExitProcess proto,dwExitCode:dword

.code
main proc
	mov	eax, num		; this is a comment
						; mov = MOVE
						; similar to eax = num
						; eax is a name of a register
	mov ebx,10+10		; another comment
	add	eax,ebx			; this doesn't get seen by assembler
						; eax = eax + ebx

	comment \
		this is a multiline comment
		you can use ANY character at all to start and end
	\

	

	invoke ExitProcess,0
main endp
end main
