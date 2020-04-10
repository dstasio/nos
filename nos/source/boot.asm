[org 0x7c00]  ; Auto-correct all pointers
mov ah, 0x0e  ; BIOS routine: scrolling teletype

; First attempt
mov al, '1'
int 0x10
mov al, ':'
int 0x10
mov al, ' '
int 0x10

mov al, first
int 0x10

mov al, 13
int 0x10
mov al, 10
int 0x10

; Second attempt
mov al, '2'
int 0x10
mov al, ':'
int 0x10
mov al, ' '
int 0x10

mov al, [second]
int 0x10

mov al, 13
int 0x10
mov al, 10
int 0x10

; Third attempt
mov al, '3'
int 0x10
mov al, ':'
int 0x10
mov al, ' '
int 0x10

mov bx, third
add bx, 0x7c00
mov al, [bx]
int 0x10

mov al, 13
int 0x10
mov al, 10
int 0x10

; Fourth attempt
mov al, '4'
int 0x10
mov al, ':'
int 0x10
mov al, ' '
int 0x10

mov al, [0x7c70]
int 0x10

mov al, 13
int 0x10
mov al, 10
int 0x10

; Infinite loop
jmp $

first:
    db "X"
second:
    db "Y"
third:
    db "Z"
fourth:
    db "W"

; Padding and magic BIOS number
times 510-($-$$) db 0
dw 0xaa55
