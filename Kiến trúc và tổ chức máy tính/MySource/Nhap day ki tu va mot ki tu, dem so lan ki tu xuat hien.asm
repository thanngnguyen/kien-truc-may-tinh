.model small
.stack 100h
.data
    s1 db "Nhap day ki tu: $"
    s2 db 10, 13, "Nhap 1 ki tu: $"
    s3 db 10, 13, "So lan ki tu xuat hien: $"
    s4 db 10, 13, "Ki tu khong xuat hien$"
    a db 100 dup(?)
.code
    main proc
        mov ax, @data
        mov ds, ax
        
        mov ah, 9
        lea dx, s1
        int 21h
        
        mov bx, 0
        
        nhap:
        mov ah, 1
        int 21h
        
        cmp al, 13
        je in_s2
        mov a(bx), al
        inc bx
        jmp nhap
        
        in_s2:
        mov ah, 9
        lea dx, s2
        int 21h
        
        mov ah, 1
        int 21h
        
        mov cx, bx
        mov bx, 0
        mov dl, 48
        
        dem:
        cmp a(bx), al
        je tang_n
        
        dem_tiep:
        inc bx
        loop dem
        
        jmp in_kq
        
        tang_n:
        inc dl
        jmp dem_tiep
        
        in_kq:
        mov bl, dl
        cmp bl, "0"
        je in_kq_0
        
        mov ah, 9
        lea dx, s3
        int 21h
        
        mov dl, bl
        
        mov ah, 2
        int 21h
        
        jmp thoat
        
        in_kq_0:
        mov ah, 9
        lea dx, s4
        int 21h
        
        thoat:
        mov ah, 4ch
        int 21h
        
    main endp
end main