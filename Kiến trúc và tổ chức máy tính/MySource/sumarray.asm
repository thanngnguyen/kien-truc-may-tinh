.model small
.stack 100h
.data
    msgn db 10, 13, 'Nhap n: $'
    n db 0
    msga db 10, 13, 'Nhap day so'
    arr db 100 dup(0)
    msgi db 10, 13, 'Nhap so: $'
    msgt db 10, 13, 'Tong: $'
    tong db 0
.code
main proc
    ; chuyen dia chi data vao cpu
    mov ax, @data
    mov ds, ax

nhapn:    
    ; in thong bao nhap n
    mov ah, 9
    lea dx, msgn
    int 21h
    
    mov cl, 10
nhaptn:    
    ; nhap n
    mov ah, 1
    int 21h
    cmp al, 13 ; kiem tra enter
    je dungn   ; neu la enter -> dung nhap
    ; kiem tra chu so
    cmp al, '0'
    jb nhapn
    cmp al, '9'
    ja nhapn
    sub al, 48 ; chuyen chu so ve so
    mov bx, 0  ; reset bx ve 0
    mov bl, al ; chuyen so vua nhap vao bl
    mov ax, 0
    mov al, n  ; chuyen n vao al
    mul cl     ; n*10
    add ax, bx ; n*10 + nhap
    mov n, al
    jmp nhaptn

dungn:
    ; thong bao nhap day
    mov ah, 9
    lea dx, msga
    int 21h
    
    mov ch, n  ; ch = n
    mov bx, 0  ; i = 0
    
nhapta:
    mov ah, 9
    lea dx, msgi
    int 21h
    
nhapti:    
    ; nhap i
    mov ah, 1
    int 21h
    cmp al, 13 ; kiem tra enter
    je dungi   ; neu la enter -> dung nhap
    ; kiem tra chu so
    cmp al, '0'
    jb nhapta
    cmp al, '9'
    ja nhapta
    sub al, 48 ; chuyen chu so ve so
    mov dx, 0  ; reset bx ve 0
    mov dl, al ; chuyen so vua nhap vao bl
    mov ax, 0
    mov al, arr[bx]  ; chuyen n vao al
    mul cl     ; n*10
    add ax, dx ; n*10 + nhap
    mov arr[bx], al
    jmp nhapti
dungi:
    inc bx
    cmp ch, bl    
    je dunga
    jmp nhapta

dunga:
    ; tinh tong
    mov ch, n  ; ch = n
    mov bx, 0 ; i = 0
    mov dx, 0 ; tong = 0
congtiep:    
    add dl, arr[bx]
    inc bx
    cmp ch, bl    
    je dungcong
    jmp congtiep

dungcong:
    mov tong, dl ; luu ket qua phep cong

    ; thong bao in tong
    mov ah, 9
    lea dx, msgt
    int 21h
    
    mov al, tong  ; chuyen n vao al
    mov bx, 0  ; dem
ct: 
    mov ah, 0  ; reset ah = 0 de ax = al
    mov dx, 0  ; reset dx = 0
    div cl     ; n/10
    add ah, 48 ; chuyen so ve chu so
    mov dl, ah
    push dx
    inc bx     ; i++
    cmp al, 0
    je dungct
    jmp ct

dungct:
    mov cx, bx
inso:
    mov ah, 2
    pop dx
    int 21h
    loop inso
    
    ; ket thuc chuong trinh
    mov ah, 4ch
    int 21h
main endp
end main