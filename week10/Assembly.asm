; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example

.386
.model flat,stdcall
.stack 4096
.data

; this is the beginning of the
; data section
; $ = "0"
; beginning of the memory
; that this program is allowed to use for data

blah BYTE ?,?

; right now... $ = 2 
; (offset in bytes from 
; the beginning of data 
; section of this program)

; symbolic constant
; using = directive

NUM_STUDENTS = 22

num dword 12

grades BYTE NUM_STUDENTS DUP(?)
; this gets replaed by assembler later
; to grades BYTE 22 DUP(?)

; we could create a symbolic constant here
GRADES_NUM_BYTES = $ - grades
; this is basically pointer arithmetic
; here... GRADES_NUM_BYTES would end up with
; value 22

moreGrades BYTE 1,2,3

ANOTHER_CONST = $ - grades
; then the $ pointer moved 3 spots over
; so ANOTHER_CONST would now be 25

result DWORD ?



week10array WORD 0AAh, 0BBh, 0CCh, 0DDh, 0EEh

; ptr examples
myDouble DWORD 12345678h

ExitProcess proto,dwExitCode:dword

.code
main proc
	mov	eax, num	
	mov ebx,10
	add	eax,ebx		; eax = eax + ebx
	sub eax, ebx	; eax = eax - ebx
	mov ecx, NUM_STUDENTS
	; gets replaced by assembler
	; mov ecx, 22
	
					; add, sub
					; and any similar
					; ops
					; CANNOT
					; use 2 memory ops
					; MUST match data types (sizes)

	mov result, eax

	; where is the result stored in RAM?
	; result is an address in memory
	; offset tells us how far from the
	; beginning of enclosing memory segment
	mov esi, OFFSET result

	comment \
	in c++
	int x = 5;
	float y = 10;
	cout << static_cast<float>(x) + y
	\

; week10array WORD 0AAh, 0BBh, 0CCh, 0DDh, 0EEh
; 16 bits
; so...
; AA is in address week10array
; BB is in address week10array + 2
; CC is in address week10array + 4
; DD is in address week11array + 6

	; i want to move BB into eax
	; op sizes don't match
	; so need to extend
	; zx or sx depends on context
	movzx eax, week10array + 2
	movzx ebx, [week10array + 2]
	; alternative syntax
	; with explicitly showing
	; dereferencing

	movzx ecx, week10array[2]
	; another alternative
	; but use carefully
	; brain normally associates this
	; as third item in array
	; bc of higher level languages
	; the index would be correct when
	; dealing with BYTE

	; if i want the third item in week10array in eax
	; third item is index 2
	; and you can calcuate the address
	; by doing 2 * data size
	movzx eax, week10array[2*2]
	WEEK10ARRAY_ELEMENT_SIZE = TYPE week10array
	; if we use TYPE operator
	movzx eax, week10array[2 * WEEK10ARRAY_ELEMENT_SIZE]



	; PTR examples
	; myDouble DWORD 12345678h
	; remember
	; in hex, 2 digits is 1 byte, or 8 bits
	; in addressing, smallest unit is 1 byte
	; so we should think of this as
	; 12 34 56 78 <- each group is 1 byte
	; the label is myDouble
	; that is the FIRST addresss
	; 78 is address 0 offset from label
	; 56 is address 1 offset from label
	; 34 is address 2 offset from label
	; 12 is address 3 offset from label

	; myDouble is 32 bits

	; myDouble is 32 bits, al is 8 bits...

	mov al,BYTE PTR  myDouble		; AL = 78h
	mov al,BYTE PTR [myDouble+1]		; AL = 56h
	mov al,BYTE PTR [myDouble+2]		; AL = 34h

	; ax is 16 bits
	mov ax,WORD PTR  myDouble		; AX = 5678h
	mov ax,WORD PTR [myDouble+2]		; AX = 1234h
	invoke ExitProcess,0
main endp
end main
