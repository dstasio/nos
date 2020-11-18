mov ah, 0x0e


mov cx, 0x7c00+intro_str
mov dx, intro_str_end-intro_str
call print_string

mov al, [secret_x]
int 0x10

mov bx, 0x7c0
mov ds, bx
mov al, [secret_y]
int 0x10

mov al, [es:secret_z]
int 0x10

mov bx, 0x7c0
mov es, bx
mov al, [es:secret_w]
int 0x10

mov cx, expected_str
mov dx, expected_str_end-expected_str
call print_string

mov cx, hex_str
mov dx, hex_str_end-hex_str
call print_string

mov bx, 0x12AF
call print_hex_16

jmp end


intro_str:
    db "Testing memory addressing: "
intro_str_end:
expected_str:
    db 10
    times 4 db 8
    db "XYZW"
    db 13
    db "Expected:"
    db 10
    db 13
expected_str_end:

secret_x:
    db "X"
secret_y:
    db "Y"
secret_z:
    db "Z"
secret_w:
    db "W"

hex_str:
    db "Hex printing: "
hex_str_end:

%include "../nos/source/print_routines.asm"

; Infinite loop, padding and magic BIOS number
end: jmp $
times 510-($-$$) db 0
dw 0xaa55
