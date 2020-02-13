PORT := $$(date +'%s')
PORT := $(shell echo "$$(( ( $(PORT) & 4095 ) + 1024))" )

all:img

img:
	mkdir -p obj
	nasm -f elf32 -g3 -F dwarf src/mbr.asm -o obj/mbr.o
	ld -Ttext=0x7c00 -melf_i386 obj/mbr.o -o obj/mbr.elf
	objcopy -O binary obj/mbr.elf mbr.img

clean:
	rm -f obj/*
	rm mbr.img

run:
	qemu-system-i386 -hda mbr.img

debug:
	qemu-system-i386 -hda mbr.img -S -s &
	gdb mbr.elf -x gdb_init_real_mode.txt -ex 'target remote localhost:1234' -ex 'break *0x7c00' -ex 'continue'
