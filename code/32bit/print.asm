[bits 32]

; Constants
VIDEO_MEMORY equ 0xb7ffc
WHITE_ON_BLACK equ 0x0f

; Procedure: prints a string
; Registers: EBX, address of length-string pair (max length: 0xFFFFFFFF)
print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY

    mov ecx, [ebx]             ; storing the string length into ecx
    add ebx, 2
    print_string_pm_loop:
        mov al, [ebx]          ; character to be printed
        mov ah, WHITE_ON_BLACK ; print attributes

        mov [edx], ax          ; storing current char in its character cell

        add ebx, 1             ; increment ebx to next char in string
        add edx, 2             ; move to next character cell in video memory

        sub ecx, 1             ; decrease counter
        cmp ecx, 0             ; if counter hasn't reached 0, loop
        jg print_string_pm_loop

        popa
        ret
