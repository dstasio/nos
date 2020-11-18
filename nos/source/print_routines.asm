;
; Procedure: prints hex value
; Expects:
;      BX value to print
;
print_hex_16:
    pusha
    mov cl, 16               ; Bit-count of the value

    mov al, '0'              ; Printing '0x'
    call print_char
    mov al, 'x'
    call print_char

    loop_hex:                ; Printing hex
        sub cl, 4
        mov dx, bx
        shr dx, cl
        and dx, 0x000f
        cmp dx, 0xA
        jge hex_letter
        hex_digit:
            add dx, '0'
            mov al, dl
            call print_char
            jmp hex_letter_end
        hex_letter:
            add dx, 'A'-0xA
            mov al, dl
            call print_char
        hex_letter_end:
        cmp cl, 4
    jge loop_hex
    popa
    ret

;
; Procedure: prints a string
; Expects:
;      CX Address of the string
;      DX Length of the string
print_string:
    push 0                ; Push initial value for counter variable
    loop_str:
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
    jmp loop_str
    return: ret

print_char: ; Prints content of al
    mov ah, 0x0e    ; BIOS routine: scrolling teletype
    int 0x10
    ret

