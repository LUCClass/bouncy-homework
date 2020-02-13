


[BITS 16]

    section .text

; your program starts executing here.
boot:


; DON'T DELETE THIS STUFF, YOU NEED IT TO BOOT
times 510-($-$$) db 0

db 0x55 ; Magic Numbers
db 0xaa ; To make disk bootable


    section .bss

; PUT ALL YOUR GLOBAL VARIABLES HERE
