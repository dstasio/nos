[org 0x7c00]    ; Auto-correct all pointers
mov ah, 0x0e    ; BIOS routine: scrolling teletype

mov bp, 0x8000  ; Set a high base address for the stack
mov sp, bp      ; Set top address of the stack

push 'A'        ; Values are pushed as 16-bit, with the
push 'B'        ; most significant byte set to 0.
push 'C'

pop bx          ; Pop 16-bits, use only low byte
mov al, bl
int 0x10        ; Print C

pop bx
mov al, bl
int 0x10        ; Print B

mov al, [0x7ffe] ; Stack grows downward, so address of A is bp-0x2 bytes
int 0x10         ; Print A

jmp $
; Padding and magic BIOS number
times 510-($-$$) db 0
dw 0xaa55
