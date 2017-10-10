[BITS 16]

jmp boot

%include "constants.inc"
%include "bios_print.inc"

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
	mov ax, STACK_SEGMENT_ADDR
	mov ss, ax
	mov sp, STACK_POINTER_ADDR

	sti ; Enable interrupts

	; Reset floppy disk
	xor ah, ah
	int 0x13

	; Read STAGE_TWO_SECTOR_COUNT sectors from floppy
	xor bx, bx
	mov ax, STAGE_TWO_SEGMENT_ADDR
	mov es, ax
	mov ah, 0x02 ; Read mode
	mov al, STAGE_TWO_SECTOR_COUNT
	mov cx, 2 ; Sector number
	int 0x13

	; Check for errors
	clc ; Clear carry flag
	mov ah, 0x01
	int 0x13
	jc error ; Exit on error

	; Jump to stage 2
	mov ax, STAGE_TWO_SEGMENT_ADDR
	mov ds, ax
	jmp STAGE_TWO_SEGMENT_ADDR:0

error:
	cli ; Disable interrupts

	; Print error message
	mov si, error_msg
	call bios_print

	; Abort program
	jmp $ ; Hang forever

error_msg:
	db "Error: Failed to read from floppy disk", 0

magic:
	; Fills rest of sector with 0
	times 510-($-$$) db 0
	; Last two bytes are bios boot signature
	dw BOOT_SIGNATURE
