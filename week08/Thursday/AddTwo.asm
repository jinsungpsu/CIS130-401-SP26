COMMENT \
	you can pick
	any character to start
	and end a multiline comment

	but... you obviously
	can't use that character
	inside the comment
	oh an array is 
	
\

.386
.model flat,stdcall
.stack 4096  ; bytes
.data
num dword 12   ; address 404000
;NUM dword 55
;Num dword 66
;nuM dword 77
num2 DWORD 13314

result DWORD 0

ExitProcess proto,dwExitCode:dword

.code
main proc
instr1: 	mov	eax, num	
	mov ebx,10				; assign value 10 decimal to ebx register
	add	eax,ebx				; add eax and ebx, save result back to eax, eax = eax + ebx	
	; mov num, num2			; can't have two memory operands
	
	mov num, 20				; what if i want to copy num into num2
	mov eax, num
	mov num2, eax

	invoke ExitProcess,0
main endp
end main
