[org 0x7c00]        ; Auto-correct all pointers

mov bl, 'A'
call print
jmp end

print:
    pusha           ; Push all registers to the stack
    mov ah, 0x0e    ; BIOS routine: scrolling teletype
    mov al, bl      ; Load parameter from bl
    int 0x10
    popa            ; Restore original register values
    ret

; Infinite loop, padding and magic BIOS number
end:
    jmp $
times 510-($-$$) db 0
dw 0xaa55
