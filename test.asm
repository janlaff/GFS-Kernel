[BITS 16]

stage_two:
    mov si, msg
    call bios_print

    jmp $

bios_print:
    lodsb
    or al, al
    jz bios_done
    mov ah, 0x0E
    int 0x10
    jmp bios_print
bios_done:
    ret

msg:
    db "Hello world", 13, 10, 0

magic:
    times 1024-($-$$) db 0
