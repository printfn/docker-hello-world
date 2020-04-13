; hello-world.asm
bits 64
        org 0x02000000

ehdr:   db 0x7f, "ELF"   ; e_ident: magic
        db 2             ; 64-bit executable

        xor eax, eax     ; automatically zeroes upper 32 bits
        inc eax          ; could also inc al, no difference
        mov esi, msg
        jmp cont2

;        db 1             ;          little-endian                         
;        db 0             ;          hp-ux abi
;        db 0             ;          version "0"
;        db 0,0,0,
          ;       padding             
        db 2,0           ; e_type: executable
        db 0x3e,0        ; e_machine (must be 0x3e == 62 for amd64)
        ;db 0,0,0,0       ; e_version (free to use for anything)
cont:   dec edi
        syscall   ; exit: rax = 60, rdi = 0
        db 5,0,0,2, 0,0,0,0  ; e_entry (entry point address)
        db 56,0,0,0, 0,0,0,0 ; e_phoff (program header offset) (IMPORTANT: = phdr - ehdr)

cont2:  mov edi, eax
        xor edx, edx
        mov dl, 12
        syscall          ; write: rax = rdi = 1, rsi = msg, rdx = 13
        xor eax, eax
        mov al, 60
        jmp cont
          ;db 0,0,0,0, 0,0,0,0  ; e_shoff (section header offset)
                     ; e_flags (processor-specific flags)
        ;db 0, 0      ; e_ehsize (elf header size)
        db 56,0      ; e_phentsize (program header size) (always equals 56, checked by linux)
phdr:   db 1, 0          ; e_phnum (number of program header entries)
        db 0, 0          ; e_shentsize (size of section header entry)
        db 5, 0          ; e_shnum (number of section header entries)
        db 0, 0          ; e_shstrndx (section name string table index)

        ; p_type (loadable segment)
        ;db 5, 0, 0, 0   ; p_flags (segment attributes, 0x1: exec, 0x2: write, 0x4: read)
        db 0,0,0,0, 0,0,0,0    ; p_offset (offset in file)
        db 0,0,0,2, 0,0,0,0    ; p_vaddr (virtual address in memory)

msg:    db 'Hello Wo'          ; p_paddr (reserved)
        db 'rld',10,1,0,0,0      ; p_filesz (size of segment in file)
        db 'rld',10,1,0,0,0      ; p_memsz (size of segment in memory)
        db 1,0,0,0, 0,0,0,0        ; p_align (alignment of segment)
