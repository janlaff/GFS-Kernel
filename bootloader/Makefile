NASM = /usr/bin/nasm
NASM_FLAGS = -f bin
OBJECTS = stage1_boot.bin stage2_boot.bin

boot.bin: $(OBJECTS)
	cat stage1_boot.bin > boot.bin
	cat stage2_boot.bin >> boot.bin

%.bin: %.asm
	$(NASM) $(NASM_FLAGS) $< -o $@

.PHONY: clean

clean:
	rm *.bin
