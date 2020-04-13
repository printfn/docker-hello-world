; hello-world.asm
bits 64
        org 0x00010000

ehdr:   db 0x7f, "ELF"      ; 7f 45 4c 46              e_ident
        db 2                ; 02                         64-bit
_start: xor eax, eax        ; 31 c0                      little-endian, hp-ux abi (both unused)
        inc eax             ; ff c0                      version (unused), padding
        mov esi, msg        ; be 50 00 01 00             5 bytes of padding
        jmp cont            ; eb 18                      2 bytes of padding
        dw 2                ; 02 00                    e_type
        dw 62               ; 3e 00                    e_machine
cont2:  dec edi             ; ff cf                    e_version
        syscall             ; 0f 05 exit
        dq _start           ; 05 00 01 00 00 00 00 00  e_entry
        dq (phdr - ehdr)    ; 38 00 00 00 00 00 00 00  e_phoff
cont:   mov edi, eax        ; 89 c7                    e_shoff
        xor edx, edx        ; 31 d2
        mov dl, 12          ; b2 0c
        syscall             ; 0f 05 write
        xor eax, eax        ; 31 c0                    e_flags
        mov al, 60          ; b0 3c
        jmp cont2           ; eb de                    e_ehsize
        dw 56               ; 38 00                    e_phentsize
phdr:   dw 1                ; 01 00                    e_phnum              p_type
        dw 0                ; 00 00                    e_shentsize
        dw 1                ; 01 00                    e_shnum              p_flags
        dw 0                ; 00 00                    e_shstrndx
        dq 0                ; 00 00                                         p_offset
        dq ehdr             ; 00 00 01 00 00 00 00 00                       p_vaddr
msg:    db 'Hello Wo'       ; 48 65 6c 6c 6f 20 57 6f                       p_paddr
        db 'rld',10,0,0,0,0 ; 72 6c 64 0a 00 00 00 00                       p_filesz
        db 'rld',10,0,0,0,0 ; 72 6c 64 0a 00 00 00 00                       p_memsz
        dq 1                ; 01 00 00 00 00 00 00 00                       p_align

; e_ident must start with 0x7f, "ELF", 2, followed by 11 arbitrary bytes
; e_type must be 2 (64-bit executable)
; e_machine must be 62 (amd64)
; e_version is arbitrary
; e_entry is the program entrypoint address
; e_phoff is program header offset
; e_shoff: section header offset (arbitrary)
; e_flags: processor-specific flags (arbitrary)
; e_ehsize: elf header size (arbitrary)
; e_phentsize: program header size: must be 56
; e_phnum: number of program header entries
; e_shentsize: size of section header entry
; e_shnum: number of section header entries
; e_shstrndx: section name string table index

; p_type: type of segment, must be 1 for loadable segment
; p_flags: segment attributes, 0x1 exec, 0x2 write, 0x4 read, 0x1 and 0x4 each imply the other
; p_offset: offset in file, must be 0
; p_vaddr: virtual address in memory
; p_paddr: reserved (arbitrary)
; p_filesz: size of segment in file
; p_memsz: size of segment in memory
; p_align: alignment of segment

; write syscall: rax = rdi = 1, rsi = msg, rdx = 12
; exit syscall: rax = 60, rdi = 0
