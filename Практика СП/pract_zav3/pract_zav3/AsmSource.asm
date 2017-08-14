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

FUNC2 PROC C x:qword, y:qword, r:qword,r1:qword
    

	    fld y
		fcomp null
		fstsw ax
		sahf
		jbe xr
		ja xr1

		xr:
		fld r
		fchs
		fstp tmp
		fld x
		fcomp  tmp
		fstsw ax
		sahf
		jae xminr2
		jb xr1

		xminr2:
		fld r1
		fchs 
		fstp tmp
		fld x
		fcomp tmp
		fstsw ax
		sahf
		jbe vyr2
		ja xr1

		xr1:
		fld r1
		;fchs
		fstp tmp
		fld x
		fcomp  tmp
		fstsw ax
		sahf
		jae xminr1
		jb xr

		xminr1:
		fld r
		;fchs 
		fstp tmp
		fld x
		fcomp tmp
		fstsw ax
		sahf
		jbe vyr1
		ja ret_false

		vyr1:
		fld x
		fld x
		fmul
		fst tmp
		fld y
		fld y
		fmul
		fld tmp
		fadd		
		fstp tmp
		fld r
		fcomp tmp
		fstsw ax
		sahf
		jbe ret_true
		ja xr1

		vyr2:
		fld x
		fld x
		fmul
		fst tmp
		fld y
		fld y
		fmul
		fld tmp
		fadd		
		fstp tmp
		fld r1
		fcomp tmp
		fstsw ax
		sahf
		jbe ret_true
		ja ret_false

		ret_true:
		fld1
		jmp ex

		ret_false:
		fldz
		jmp ex

		ex:
ret
FUNC2 ENDP
END