[BITS 16]

jmp stage_two

%include "stagex_boot.inc"
%include "bios_print.inc"

stage_two:
    mov si, msg
    call bios_print

    jmp $ ; Hang forever

msg:
    db "Hello world", 13, 10, 0

magic:
    times 1024-($-$$) db 0
