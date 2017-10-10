[BITS 16]

%include "stagex_boot.inc"

boot:
    mov ax, STAGE_ONE_SEGMENT_ADDR
    mov ds, ax
    jmp STAGE_ONE_SEGMENT_ADDR:stage_one

stage_one:
    ; Initialize segment registers
    xor ax, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    cli ; Disable interrupts

    ; Setup stack
    mov ax, STAGE_ONE_STACK_SEGMENT_ADDR
    mov ss, ax
    mov sp, STAGE_ONE_STACK_PTR_ADDR

    sti ; Enable interrupts
    
    ; Reset floppy disk
    int 0x13

    ; Read STAGE_TWO_SECTOR_COUNT sectors from floppy
    xor bx, bx
    mov ax, STAGE_TWO_SEGMENT_ADDR
    mov es, ax
    mov ah, 0x02 ; Read mode
    mov al, STAGE_TWO_SECTOR_COUNT
    mov cx, 2 ; Sector number
    int 0x13

    ; Jump to stage 2
    mov ax, STAGE_TWO_SEGMENT_ADDR
    mov ds, ax
    jmp STAGE_TWO_SEGMENT_ADDR:0

magic:
    ; Fills rest of sector with 0
    times 510-($-$$) db 0
    ; Last two bytes are bios boot signature
    dw BOOT_SIGNATURE
