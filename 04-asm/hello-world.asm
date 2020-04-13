; hello-world.asm
bits 64
        org 0x00010000

ehdr:   db 0x7f, "ELF"      ; e_ident
        db 2
_start: xor eax, eax
        inc eax
        mov esi, msg
        jmp cont
        dw 2                ; e_type
        dw 62               ; e_machine
cont2:  dec edi             ; e_version
        syscall  ; exit
        dq _start           ; e_entry
        dq (phdr - ehdr)    ; e_phoff
cont:   mov edi, eax        ; e_shoff
        xor edx, edx
        mov dl, 12
        syscall  ; write
        xor eax, eax        ; e_flags
        mov al, 60
        jmp cont2           ; e_ehsize
        dw 56               ; e_phentsize
phdr:   dw 1                ; e_phnum          p_type
        dw 0                ; e_shentsize
        dw 1                ; e_shnum          p_flags
        dw 0                ; e_shstrndx
        dq 0                ;                  p_offset
        dq ehdr             ;                  p_vaddr
msg:    db 'Hello Wo'       ;                  p_paddr
        db 'rld',10,0,0,0,0 ;                  p_filesz
        db 'rld',10,0,0,0,0 ;                  p_memsz
        dq 1                ;                  p_align

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
