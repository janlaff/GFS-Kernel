[BITS 16]

jmp stage_two

%include "boot.inc"
%include "bios_print.inc"

stage_two:
	jmp $

magic:
	times (512 * STAGE_TWO_SECTOR_COUNT)-($-$$) db 0
