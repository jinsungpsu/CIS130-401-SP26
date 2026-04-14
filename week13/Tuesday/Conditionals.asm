COMMENT \
	CIS130
\

.386
.model flat,stdcall
.stack 4096  ; bytes
.data

arr BYTE 1,2,3,-5,-6,-7,8,9,-10
sum BYTE ?

ExitProcess proto,dwExitCode:dword

.code

main proc

	MOV ecx, LENGTHOF arr
	MOV esi, OFFSET arr

LOOP_START:
	; add sum, [esi] ; <- don't do this RAM IS SLOWWWWWWWW

	; if arr[i] > 0
	CMP BYTE PTR [esi], 0 ; <- this doesn't actually do
				 ; if arr[i] > 0
				 ; non destructive subtraction
				 ; and setting flags
	JG GREATER   ; jump if greater
				 ; meaning jump if arr[i] > 0
				 ; jump where?
	JMP NOT_GREATER
GREATER:
	movzx EAX, BYTE PTR [esi]	; it's going to move only positive values
					; into EAX while looping through the arr

	JMP AFTER
NOT_GREATER:
	movsx ebx, BYTE PTR [esi]

AFTER:
	inc esi

	LOOP LOOP_START

	invoke ExitProcess,0
main endp
end main
