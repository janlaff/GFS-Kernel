[BITS 16]

jmp stage_two

%include "boot.inc"
%include "bios_print.inc"

stage_two:
	; Detect low memory
	clc ; Clear carry flag
	int 0x12 ; Query low memory size
	jc low_mem_error ; Exit on error

	; Check id enough space is free
	cmp ax, STAGE_TWO_BUFFER_SIZE
	jl insufficent_mem_error

done:
	jmp $
	
error:
	call bios_print
	jmp done

low_mem_error:
	mov si, low_mem_error_str
	jmp error

insufficent_mem_error:
	mov si, insufficent_mem_error_str
	jmp error

low_mem_error_str:
	db "Failed to get low memory", 13, 10, 0

insufficent_mem_error_str:
	db "Not enough memory available", 13, 10, 0

magic:
	times (512 * STAGE_TWO_SECTOR_COUNT)-($-$$) db 0
