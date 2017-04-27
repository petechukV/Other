#include <iostream>
using namespace std;
void main()
{
	_asm
	{
		//mov ax, 12h
			//int 10h
		//	;;;;;;;;;;;;;;;; home
			mov ah, 00
			int 16h
			cmp al, 00
			jne exit1
			cmp ah, 47h
			jne exit2
			mov ah, 02
			mov bh, 00
			; mov dx, 00
			int 10h
			//;;;;;;;;;;;;;; end
			cmp al, 00
			jne exit1
			cmp ah, 4fh
			jne exit2
			mov ah, 02
			mov bh, '$'
			int 10h
			//;;;;;;;;;;;;;;; ESK
			CMP AL, 00
			jne exit1
			cmp ah, 01h
			jmp a
			exit1 :
		MOV AH, 00
			INT 16H
			exit2 :
		MOV AH, 00
			INT 16H
			a :
	}
	system("pause>>void");
}
