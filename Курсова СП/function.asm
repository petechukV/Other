;---------------------------------------------------------------------
;  Підпрограма запису цілого числа з клавіатури з перевіркою на знак
;---------------------------------------------------------------------
;	Параматри
;  		ax - введене число
;---------------------------------------------------------------------
InputPInt proc
;збереження значень регістрів у стек
    push dx
    push bx
    push cx
    push si
    push di
    push ds
    push cs
    pop ds
;при невдалому введенні спробувати знову
@@again:
	PRINT "> "
	;функція вводу символу з клавіатури
    mov ah,0ah
    xor di,di
    mov dx, offset @@buff	
    int 21h
	
    mov dl,0ah
    mov ah,02
    int 21h
;обробляємо значення буфера
;адрес початку строки
    mov si, offset @@buff+2 
    cmp byte ptr [si], "-"	;перевірка першого символу на мінус
    jnz @@ii1
	jmp @@er
@@ii1:
    xor ax, ax
    mov bx, 10				;ініціалізація основи системи числення  
@@ii2:
    mov cl,[si] 			;беремо символ з буферу
    cmp cl,0dh  			;перевіряємо, чи не останній він
    jz @@enddecin
;якщо символ не останній, перевіряємо на правильність вводу
    cmp cl,'0'  
    jl @@er
    cmp cl,'9'  
    ja @@er
 ;перетворюємо символ в 10-ве число
    sub cl,'0'
    mul bx   
    add ax,cx
    inc si    
    jmp @@ii2  
;вивід повідомлення про помилку вводу
@@er:  
    PRINTN "Invalid number!Try again."
    jmp @@again
@@enddecin:
;відновлюємо значення регістів
	cmp ax, 0
	je @@er
    pop ds
    pop di
    pop si
    pop cx
    pop bx
    pop dx
    ret							
@@buff   		db 6,7 Dup(?)
InputPInt endp
;---------------------------------------------------------------------
;Підпрограма запису відповіді в файл
;---------------------------------------------------------------------
;Параматри:
;	нічого
;---------------------------------------------------------------------
InputToFile proc
	;Відкриваємо файл
	mov ah,3ch
	xor cx, cx
	lea dx, fn
	int 21h
	;При помилці відкриття виходимо
	jc @exit
	mov dscr, ax
	mov si, 0		;ітератор
	mov di, Count
	;ініціалізуємо цикл
@@again:
	cmp di, 0
	je @exit
	;вибираємо число з масиву
	xor cx,cx
	mov ax, array[si]
	add si, 2
	;якщо число відємне, то приводимо його до відповідного типу
	test ax, ax
	jns pos
	neg ax
	push ax
	push bx
	push cx
	push dx
	mov ah, 40h
	mov bx, dscr
	mov cx, 1
	mov dx, offset minus
	int 21h
	pop dx
	pop cx
	pop bx
	pop ax
	;інакше продовжуємо
pos:
	;перетворюємо число
	mov bx, 10
div10:
	xor dx,dx
	div bx
	push dx
	inc cx
	or ax, 0
	jnz div10
	mov dx, cx
	xor bx, bx
nxt:
	pop ax
	add ax, 30h
	mov buf[bx], ax
	inc bx
	loop nxt
;записуємо переведене число в файл
	mov ah, 40h
	mov bx, dscr
	mov cx, dx
	lea dx, buf
	int 21h
	;записуємо пробіл
	mov ah, 40h
	mov bx, dscr
	mov cx, 1
	mov dx, offset space
	int 21h

;декрементуємо di та при необхідності повторюємо
	dec di
	jmp @@again
@exit:
    ret	
InputToFile endp
;--------------------------------------------------------------------
;блочная сортировка массива слов
;на входе
; cx    - длина массива
; ds:dx - указатель на массив
bucketSort      proc
;объявление переменных
LOCAL   buckets:word:(hor*ver), X:word, Ten:word, Count1:word,
;выделение памяти в стеке под переменные (т.к. язык не указан - делаем вручную)
        push    bp
        mov     bp,     sp
        sub     sp,     hor*ver*2+3*2   ;размер локальных переменных
        ;сохранение регистров
        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        ;вспомогательная переменная
        mov     Ten,    10
        ;for(x=1; x<=100; x *= 10)
        mov     X,      1
@@ForX:
        ;всем элементам buckets присваиваем метку "не использовалось" значение (-1)
        push    cx
        push    es
        push    ss
        pop     es
        mov     ax,     -1 kets
        mov     cx,     (hor*ver)
        rep     stosw
        pop     es
        pop     cx
 
        ;count = 0      //обнуляем счётчик ячеек исходного массива чисел
        ;на самом деле Count - смещение в исходном массиве, а не просто индекс
        mov     Count1,  0
        ;for(i=0; i < size; i++)
        push    cx
        push    dx
        mov     bx,     dx      ;задание базы для обращения к исходному массиву
        mov     si,     0       ;i=0
        @@ForI:
                mov     ax,     [bx+si] ;ax=array[i]
                mov     dx,     0       ;temp=array[i] / x
                div     X
                mov     dx,     0       ;oststok = temp % 10
                div     Ten
                mov     ax,     dx      ;ax - остаток от деления
 
                mov     di,     hor*2   ;получаем смещение в двумерном массиве
                mul     di
                add     ax,     si
                mov     di,     ax      ;di = смещение, соответствующее bucket[ostatok][i]
 
                mov     ax,     [bx+si] ;ax = array[i]
                mov     buckets[di],ax  ;buckets[oststok][i] = array[i]
 
                add     si,     2       ;i++ (т.к. si - смещение, то увеличиваем на размер элемента)
        loop    @@ForI
        pop     dx
        pop     cx
 
        ;вложенные циклы по всем элементам buckets проще представить
        ;одним циклом по всем элементам с индексом от 0 до (hor*ver-1)
        ;т.к. ячейки двумерного массива располагаются в памяти последовательно и
        ;построчно
        ;for(i=0; i<hor; i++)
        ;  for(j=0; j<ver;j++)
        push    cx
        push    dx
        mov     cx,     (hor*ver)
        mov     di,     0
        mov     bx,     dx
        @@ForIJ:
                mov     ax,     buckets[di]     ;if (buckets[i][j] != -1
                cmp     ax,     -1
                je      @@Skip
                mov     si,     Count1           ;  array[count] = bucket[i][j]
                mov     [bx+si],        ax
                add     Count1,  2               ;  count++
        @@Skip:
                add     di,     2               ;i++, j++
        loop    @@ForIJ
        pop     dx
        pop     cx
 
        mov     ax,     X       ;X:= X*10
        add     ax,     ax      ;ax = 2*X
        mov     bx,     ax      ;bx = 2*X
        add     ax,     ax
        add     ax,     ax      ;ax= 8*X
        add     ax,     bx      ;ax = 10*X
        mov     X,      ax
 
        cmp     X,      100
        ja      @@BreakForX
        jmp     @@ForX
 
@@BreakForX:
 
        ;восстановление регистров
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ;освобождение памяти от локальных переменных
        mov     sp,     bp
        pop     bp
        ;возврат из процедуры и освобождение памяти от аргументов
        ret     0
bucketSort      endp

;--------------------------------------------------------------
;  Підпрограма запису цілого 10-числа з клавіатури
;--------------------------------------------------------------
;	Параматри
;  		ax - введене число
;--------------------------------------------------------------
InputInt proc
;збереження значень регістрів у стек
    push dx
    push bx
    push cx
    push si
    push di
    push ds
    push cs
    pop ds
	
;при невдалому введенні спробувати знову
again:
	PRINT ">"
	
	;функція вводу символу з клавіатури
    mov ah,0ah
    xor di,di
    mov dx, offset buffs	
    int 21h
	
    mov dl,0ah
    mov ah,02
    int 21h
	
;обробляємо значення буфера
;адрес початку строки
    mov si, offset buffs+2 
    cmp byte ptr [si], "-"	;перевірка першого символу на мінус
    jnz ii1
    mov di,1  
    inc si    
ii1:
    xor ax,ax
    mov bx,10				;ініціалізація основи системи числення  
ii2:
    mov cl,[si] 			;беремо символ з буферу
    cmp cl,0dh  			;перевіряємо, чи не останній він
    jz enddecin
    
;якщо символ не останній, перевіряємо на правильність вводу
    cmp cl,'0'  
    jl er
    cmp cl,'9'  
    ja er
	
 ;перетворюємо символ в 10-ве число
    sub cl,'0'
    mul bx   
    add ax,cx
    inc si    
    jmp ii2  
	
;вивід повідомлення про помилку вводу
er:  
    PRINTN "Invalid number!Try again."
    jmp again
;якщо встановлений флаг, то робимо число відємним
enddecin:
    cmp di,1 
    jnz ii3
    neg ax   
ii3:
;відновлюємо значення регістів
    pop ds
    pop di
    pop si
    pop cx
    pop bx
    pop dx
	
    ret							
	
buffs   		db 6,7 Dup(?)
InputInt endp
;--------------------------------------------------------------
;Підпрограма виводу цілого 10-го числа
;--------------------------------------------------------------
; Параматри:
;  ах - чило для виводу
;--------------------------------------------------------------
OutInt proc
;Зберігаємо значення регістрів
    push ax
    push dx
    push bx
    push cx
    push ds
    push di
    push cs
    pop ds
	;Перевіряємо число на знак
    test ax, ax
    jns oi1
    mov di, 1
    neg ax
oi1:
    xor cx, cx
    mov bx, 10				;основа СЧ
oi2:
    xor dx, dx
    div bx
    add dx, '0'
    push dx					;зберігаємо значення в стек
    inc cx
	;Відділяємо цифру справа поки не залишиться 0
    test ax, ax
    jne oi2
	;Виводимо отримане значення
    mov ah, 2
    cmp di, 1
    jne oi3
	;При відємному числі виводимо знак '-'
    mov dl, '-'
    int 21h
oi3:
    pop dx					;Виштовхеємо цифру, переводимо її в символ і виводимо
    int 21h
    loop oi3				;повторюємо стільки разів, скільки цифр було нараховано
;Відновлюємо значення регістрів
    pop di
    pop ds
    pop cx
    pop bx
    pop dx
    pop ax
	
    ret
OutInt endp
;-------------------------------------------------------------
; Підпрограма заповнення массива з клавіатури
;-------------------------------------------------------------
; Параматри:
; 	сх  - кількість елементів у масиві
;-------------------------------------------------------------
GetArray proc
    mov cx, count   ;довжина массива
    mov bx, 0		;ітератор
@@1:
    call InputInt
    mov array[bx], ax
    add bx, 2
    loop @@1
	
    ret
GetArray endp

;------------------------------------------------------------
; Підпрограма виводу масиву на консоль
;------------------------------------------------------------
; Параматри
;	сх - довжина массива
;------------------------------------------------------------
OutArray proc
	cmp count, 0
	je @@Exit
	
    mov cx, count   ;довжина массива
    mov bx, 0
    mov dl, ' '
@@2:
    mov ax, array[bx]
    call OutInt
    mov ah, 2
    int 21h
	
    add bx, 2
    loop @@2
@@Exit:
    ret
OutArray endp

;-----------------------------------------------------------------
;Процедура відкриття файлу
;-----------------------------------------------------------------
;Параматри
; 	немає
;-----------------------------------------------------------------
OpenFileRead    PROC   	
	mov ah,3dh		
	mov al,0		
	int 21h
	
	ret			
OpenFileRead    ENDP              

;-------------------------------------------------------------
;Процедура закриття файлу
;------------------------------------------------------------
;Параматри:
;   BX декриптор файла
;-------------------------------------------------------------
CloseFile    PROC   
     	mov ah,3eh		
		int 21h
		ret			
CloseFile    ENDP  

;------------------------------------------------------------------
;Процедура виходу з проограми
;------------------------------------------------------------------
;Параматри:
;	немає
;----------------------------------------------------
ExitProgramm   PROC 
	mov  ah,0      
    mov  al,2      
    int  10h 
	
	mov ah,04Ch 	
	mov al,0h 	
	int 21h 	
ExitProgramm    ENDP
;------------------------------------------------------------------------
;Процедура вивиду рядку символів на екран
;------------------------------------------------------------------------
;Параматри:
;	bx - символ для виводу
;------------------------------------------------------------------------
WriteStr    PROC   
     mov ah,09h
     int 21h
	 
     ret
WriteStr  ENDP
  
  
;-----------------------------------------------------------------------
;функція читання з файлу
;----------------------------------------------------------------------
ReadFromFile proc
	;Відкриваємо файл
	mov dx, offset fname
	call OpenFileRead
	mov handle, ax
	
	mov buff, 0
  	mov position, 0	
	xor si, si		
	xor di, di		
	
@@again:
	;--------------------------------------------------------------------
	;Покажчик на потрібну позицію
	mov bx, handle
	mov al, 0
	mov cx, 0
	mov dx, position			
	mov ah, 42h
	int 21h
	inc position	;Зміщуємо позицію 
	
	;Читаємо з файлу
	mov bx, handle
	mov ah, 3fh
	mov cx, 1			;Зчитуємо по 1 байту
	mov dx, offset t_buff
	int 21h
	
;Перевіряємо на кінець файлу
	cmp t_buff, '$'
	je Exit
	
;Перевіряємо на відємне число
	cmp t_buff, '-'
	jne @@postv
	mov di, 1
	jmp @@again
	
@@postv:
;Перевіряємо на пробіл
	cmp t_buff, ' '
	jne @@cont
	
;Якщо пробіл, записуємо значення в масив
	cmp position, 3
	jne @@ncount
	push buff
	pop  count
	mov buff, 0
	jmp @@again
@@ncount:
	cmp di,1 
    jne @@pos
	mov bx, buff
    neg bx
	mov buff, bx
@@pos:

	mov bx, buff
	mov array[si], bx
	add si, 2			;Зміщуємо позицію
	mov buff, 0
	xor di, di
	jmp @@again
	
@@cont:
	xor ch, ch
	mov cl, t_buff
	
	;перевіряємо на правильність вводу
    cmp cl,'0'  
    jl Exit
    cmp cl,'9'  
    ja Exit
	
	;початкові установки
    mov bx, 10				;ініціалізація основи системи числення  

 ;перетворюємо символ в 10-ве число
    sub cl,'0'
	xor ch, ch
	
	mov ax, buff
	mul bx
	add ax, cx
	mov buff, ax
	
	jmp @@again
Exit:
	mov bx, handle
	Call CloseFile
	jc Exit
	ret
ReadFromFile endp
