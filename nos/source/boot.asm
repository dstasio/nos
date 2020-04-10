[org 0x7c00]    ; Auto-correct all pointers
mov ah, 0x0e    ; BIOS routine: scrolling teletype

mov bx, 50
cmp bx, 4
jle cond_le4
cmp bx, 40
jl  cond_l40
mov al, 'C'
jmp print

cond_le4:
    mov al, 'A'
    jmp print
cond_l40:
    mov al, 'B'
    jmp print

print:
    int 0x10

jmp $
; Padding and magic BIOS number
times 510-($-$$) db 0
dw 0xaa55
