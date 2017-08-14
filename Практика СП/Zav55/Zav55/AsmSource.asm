.586
.MODEL FLAT, C
.DATA
 mn5 dq -6.0
 mn3 dq -4.0
 mn1 dq 0.0
 two dq 2.0
 four dq 4.0
 dvin dq 12.0
 five dq 5.0
 co5 dq -0.5
 null dq 0.0
 tmp dq ?
.CODE
FUNC1 PROC C x:qword  
      
		fld x
		fcomp mn5
		fstsw ax
		sahf
		jb mz		
		
		fld x
		fcomp mn3
		fstsw ax
		sahf
		jb m1		

		fld x
		fcomp mn1
		fstsw ax
		sahf
		jb m2

		fld x
		fcomp two
		fstsw ax
		sahf
		jb m3		
		
		fld x
		fcomp dvin
		fstsw ax
		sahf
		jb m4
		ja mz

		m1:
		fld two
		fchs		
		jmp ex

		m2:
		fld four
		fld1
		fdivr
		fld x
		fmul
		jmp ex

		m3:
		fld x
		fld x
		fmul
		jmp ex

		m4:
		fld co5
		fld x
		fmul
		fld five
		fadd
		jmp ex		

		mz:
		fldz
		jmp ex
		ex:
		ret
FUNC1  ENDP
END