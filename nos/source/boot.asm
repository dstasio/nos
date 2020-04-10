mov ah, 0x0e  ; BIOS routine: scrolling teletype

; First attempt
mov al, first
int 0x10

; Second attempt
mov al, [second]
int 0x10

; Third attempt
mov bx, third
add bx, 0x7c00
mov al, [bx]
int 0x10

; Fourth attempt
mov al, [0x7c1e]
int 0x10

jmp $

first:
    db "X"
second:
    db "Y"
third:
    db "Z"

; Padding and magic BIOS number
times 510-($-$$) db 0
dw 0xaa55
