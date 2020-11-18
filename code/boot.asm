[org 0x7c00]

    mov [BOOT_DRIVE], dl  ; BIOS stores our boot drive in DL
    
    mov bp, 0x8000        ; setting stack out of the way
    mov sp, bp
    
    mov bx, 0x9000        ; Load 5 sectors to 0x0000(ES):0x9000(BX)
    mov dh, 5
    mov dl, [BOOT_DRIVE]
    call bios_disk_load

    mov bx, [0x9000]      ; Printing the first loaded word, expected to be 0xdada
    call bios_print_hex_16

    mov al, 10
    call bios_print_char
    mov al, 13
    call bios_print_char

    mov bx, [0x9000 + 512] ; Also printing the first word from the 2nd sector
                           ; expected to be 0xface
    call bios_print_hex_16

    jmp end

%include "bios/disk.asm"
%include "bios/print.asm"

; Global variables
BOOT_DRIVE: db 0

; Infinite loop, padding and magic BIOS number
end: jmp $
times 510-($-$$) db 0
dw 0xaa55

; We know that BIOS will load only the first 512-byte sector from the disk,
; so if we purposely add a few more sectors to our code by repeating some
; familiar numbers , we can prove to ourselfs that we actually loaded those
; additional two sectors from the disk we booted from.
times 256 dw 0xdada
times 256 dw 0xface
