NASM = /usr/bin/nasm
NASM_FLAGS = -f bin
OBJECTS = stage1_boot.bin test.bin

boot.img: $(OBJECTS)
	dd if=stage1_boot.bin of=boot.img
	dd if=test.bin of=boot.img oflag=append

%.bin: %.asm
	$(NASM) $(NASM_FLAGS) $< -o $@
