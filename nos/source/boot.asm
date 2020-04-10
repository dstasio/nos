mov ah, 0x0e
mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10
mov al, 'o'
int 0x10
mov al, ' '
int 0x10
mov al, 'P'
int 0x10
mov al, 'a'
int 0x10
mov al, 's'
int 0x10
mov al, 't'
int 0x10
mov al, 33
int 0x10

jmp $

times 510-($-$$) db 0
dw 0xaa55
