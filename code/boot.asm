[org 0x7c00]

    mov bp, 0x9000      ; Setting the stack.
    mov sp, bp

;      CX Address of the string
;      DX Length of the string
    mov cx, MSG_REAL_MODE
    mov dx, MSG_REAL_MODE_LEN
    call bios_print_string

    call switch_to_pm  ; We never return from here.

    jmp $


%include "bios/print.asm"
%include "32bit/gdt.asm"
%include "32bit/print.asm"


[bits 16]
; Switch to protected mode
switch_to_pm:
    cli                      ; switching off interrupts
    lgdt [gdt_descriptor]    ; loading global descriptor table

    mov eax, cr0             ; setting the first bit of cr0
    or eax, 0x1              ; to instruct the CPU to switch
    mov cr0, eax             ; to protected mode.

    jmp CODE_SEG:init_pm     ; Make a far jump (to a new segment)
                             ; to force the CPU to flush its cache of
                             ; pre-fetched real-mode instructions.

[bits 32]
; Initialize registers and the stack in PM.
init_pm:
    mov ax, DATA_SEG  ; Once in PM, the old segments are meaningless,
    mov ds, ax        ; so we point the segment registers to the
    mov ss, ax        ; data sector defined in the GDT
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000  ; Pointing the stack at the top of the free space.
    mov esp, ebp

    call BEGIN_PM

BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm    ; Using 32-bit print routine.

    jmp $


; Global variables
MSG_REAL_MODE:
    db "Started in 16-bit Real Mode"
MSG_REAL_MODE_LEN equ ($ - MSG_REAL_MODE)

MSG_PROT_MODE:
    dd MSG_PROT_MODE_LEN
    db "Successfully landed in 32-bit Protected Mode"
MSG_PROT_MODE_LEN equ ($ - MSG_PROT_MODE - 2)

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55

; We know that BIOS will load only the first 512-byte sector from the disk,
; so if we purposely add a few more sectors to our code by repeating some
; familiar numbers , we can prove to ourselfs that we actually loaded those
; additional two sectors from the disk we booted from.
times 256 dw 0xdada
times 256 dw 0xface

