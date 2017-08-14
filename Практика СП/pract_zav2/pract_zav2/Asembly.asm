.MODEL FLAT, C
.stack 1024h
.CODE
FUNC1 PROC C a:qword
finit
fld a
fsincos
fsubr 
fld a
fsincos
fadd 
fdivr 
ret
FUNC1 ENDP

;proc 2

FUNC2 PROC C a1:qword,b:qword,c1:qword
finit
fld a1  ;st1
fld c1  ;st
fmul 
fptan
fmul 
fld1  ;st2
fld a1 ;st1
fld c1 ;st
fmul 
fcos
fdiv 
fadd  
ret
FUNC2 ENDP
END