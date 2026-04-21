COMMENT \
	CIS130
\

.386
.model flat,stdcall
.stack 4096  ; bytes
.data

; multiplication
; "easy" -> simple
; don't worry about multiple registers

xb BYTE 5
yb BYTE 10
zw WORD ?		; if we do xb * yb, the result is 16 bits
				; 8 bits x 8 bits = 16 bits

xw WORD 5000
yw WORD 500
zdw DWORD ?


; let's do some division
; a / b = c R d
; big / small = small R small
; 64 bit / 32 bit = 32 bit R 32 bit

aqw QWORD 0AAABBBBCCCCDDDDh	; <- very large #
bdw DWORD 0AAABBBBh			; <- smaller
cdw DWORD ?						; <- quotient
ddw DWORD ?						; remainder


ExitProcess proto,dwExitCode:dword
.code
main proc

	; multiplication
	; right now, as we learn the basics
	; we use implied operand/result

	; for 8 bit, one operand will be AL
	; the other will be specified
	; in the instruction

	mov al, yb
	MUL xb		; this means
				; ax = xb * al

	mov zw, ax

	; now let's do something
	; slightly more annoying
	; 16 bit x 16 bit = 32 bits
	; we still have implied operands
	
	mov ax, yw
	MUL xw		; <-- xw x ax = dx:ax 
				; (with carry flag set accordingly)

	; mov zdw, ???
	mov WORD PTR zdw, ax
	mov WORD PTR [zdw + 2], dx


	; division
	; big / small = small R small

	; EDX:EAX <--- 64 bit operand
	; there are NO 64 bit registers, so we split it up into 2 places
	MOV EAX, DWORD PTR aqw
	MOV EDX, DWORD PTR [aqw + 4]

	DIV bdw ; <-- currently this is an integer overflow error, looking into it

	; now the result should be in EAX <- quotient and EDX <- remainder

	invoke ExitProcess,0
main endp
end main
