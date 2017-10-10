[BITS 16]

STAGE_TWO_SECTOR_COUNT equ 1
STAGE_ONE_SEG_ADDR equ 0x7C0
STAGE_TWO_SEG_ADDR equ 0x100
STACK_SEG_ADDR equ 0x7E0
STACK_PTR_ADDR equ 0x200

boot:
    mov ax, STAGE_ONE_SEG_ADDR
    mov ds, ax
    jmp STAGE_ONE_SEG_ADDR:stage_one

stage_one:
    ; Initialize segment registers
    xor ax, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    cli ; Disable interrupts

    ; Setup stack
    mov ax, STACK_SEG_ADDR
    mov ss, ax
    mov sp, STACK_PTR_ADDR

    sti ; Enable interrupts
    
    ; Reset floppy disk
    int 0x13

    ; Read STAGE_TWO_SECTOR_COUNT sectors from floppy
    xor bx, bx
    mov ax, STAGE_TWO_SEG_ADDR
    mov es, ax
    mov ah, 0x02 ; Read mode
    mov al, STAGE_TWO_SECTOR_COUNT
    mov cx, 2 ; Sector number
    int 0x13

    ; Jump to stage 2
    mov ax, STAGE_TWO_SEG_ADDR
    mov ds, ax
    jmp STAGE_TWO_SEG_ADDR:0

magic:
    ; Fills rest of sector with 0
    times 510-($-$$) db 0
    ; Last two bytes are bios boot signature
    dw 0xAA55
