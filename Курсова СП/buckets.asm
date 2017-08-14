LOCALS
.model small, NOLANGUAGE
.stack 1024h
.data
    array   dw 80 dup (0)
	ArSize  equ     ($-array)/2
    ver     equ     ArSize+1
	count	dw	0
	fn 		db 'bucket.txt', 0
	dscr    dw ?
	space	dw ' '
	minus 	dw '-'
	endfl	dw '$'
	buf 	dw 5 dup (?)
	fname 	db 'data.txt', 0h
	handle  dw '?'
	buff	dw '?'
	position dw 0
	t_buff db ?
	hor     equ     10  
.code
LOCALS @@		;для використання локальних міток в процедурах
JUMPS				;для виконання стрибку понад 128 байт
INCLUDE macro.asm	;підключення файлу з макросами
start:
    mov ax, @data	
    mov ds, ax
	
	;Вивід початкового меню
_again:
	call ShowMenu
	call InputPInt
	cmp ax, 1
	je SetUp
	cmp ax, 2
	je Rmfile
	cmp ax, 3
	je PrintMas
	cmp ax, 4
	je Sorted
	cmp ax, 5
	je SaveAnswer
	cmp ax, 6
	je _eexit
	jmp _again
	;ініціалізація початкових данних
SetUp:
	PRINT "Enter the number of element in massive "
	call InputPInt
	mov Count, ax
	PRINTN "Enter the elements of massive: "
	call GetArray
	PRINTN "Digit successfully inputed! "
	xor ax, ax			;Зачекати на нажаття клавіші
    int 16h
	jmp _again
Rmfile:
	call ReadFromFile
	PRINTN "Array successfully readed! "
	xor ax, ax			;Зачекати на нажаття клавіші
    int 16h
	jmp _again
	;виведення массиву на екан
PrintMas:
	PRINT "Array at the moment { "
	call OutArray
	PRINT "}"
	xor ax, ax			;Зачекати на нажаття клавіші
    int 16h
	jmp _again
	;Виклик процедури сортування
Sorted:
	lea dx, array
	mov cx, Count
	call BucketSort
	PRINTN "Array successfully sorted!"
	xor ax, ax			;Зачекати на нажаття клавіші
    int 16h
	jmp _again
	;збереження відповіді в файл
SaveAnswer:
	call InputToFile
	PRINTN "Array  will be saved..."
	xor ax, ax			;Зачекати на нажаття клавіші
    int 16h
	jmp _again
_eexit:
	call ExitProgramm
INCLUDE function.asm	;Підключення файлу з основними функціями, які використовуються даною програмою
;Підпрограмма виводу 
ShowMenu proc

    mov  ah,0      
    mov  al,2      
    int  10h       
	PRINTN "|                                 <MENU>                                       |"
	PRINTN "|==============================================================================|"
	PRINTN "|     Supported command;                                                       |"
	PRINTN "|  <1> -- Input array from keyboard;                                           |"
	PRINTN "|  <2> -- Input array from file;                                               |"
	PRINTN "|  <3> -- Show array;                                                          |"
	PRINTN "|  <4> -- Sorted array;                                                        |"
	PRINTN "|  <5> -- Save array to file 'bucket.txt';                                     |"
	PRINTN "|  <6> -- Exit;                                                                |"
	PRINTN "|============================================================================= |"
	PRINT  "Command "
	
	ret
ShowMenu endp
end start
