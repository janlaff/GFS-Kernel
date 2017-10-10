[BITS 16]

jmp stage_two

%include "boot.inc"
%include "bios_print.inc"

stage_two:
	; Detect low memory
	clc ; Clear carry flag
	int 0x12 ; Query low memory size
	jc low_mem_error ; Exit on error

done:
	jmp $
	
low_mem_error:
	mov si, low_mem_error_str
	call bios_print
	jmp done

low_mem_error_str:
	db "Failed to get low memory", 13, 10, 0

magic:
	times (512 * STAGE_TWO_SECTOR_COUNT)-($-$$) db 0
