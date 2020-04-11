[org 0x7c00]        ; Auto-correct all pointers
mov bp, 0x8000
mov sp, bp

mov dx, len0
mov cx, string0
call print_string
mov dx, len1
mov cx, string1
call print_string
jmp end

;
; Procedure: prints a string
; Expects:
;       CX Address of the string
;       DX Length of the string
print_string:
    push 0                ; Push initial value for counter variable
    loop:
        pop bx            ; Pop counter variable and
        cmp bx, dx        ; compare it to the length of the string
        jge return
        mov ax, cx        ; If it's less than the length,
        add ax, bx        ; offset string-address by the value of the counter.
        add bx, 1         ; Increment counter.
        push bx           ; Push counter.
        mov bx, ax
        mov al, [bx]      ; Load the current character in al to print.
        call print_char
    jmp loop
    return: ret

print_char: ; Prints content of al
    mov ah, 0x0e    ; BIOS routine: scrolling teletype
    int 0x10
    ret

string0: db "Hey strings. "
len0:    equ $-string0
string1: db "Let's take over the world!"
len1:    equ $-string1
    

; Infinite loop, padding and magic BIOS number
end: jmp $
times 510-($-$$) db 0
dw 0xaa55
