; hello-world.asm
bits 64
        org 0x08048000

; $:  beginning of the current line
; $$: beginning of the current section

ehdr:
	db 0x7f, "ELF" ; e_ident: magic
        db 2           ;          64-bit
        db 1           ;          little-endian
        db 1           ;          hp-ux abi
        db 0           ;          version "0"
times 8 db 0           ;          padding
	dw 2           ; e_type: executable
        dw 0x3e        ; e_machine
        dd 1           ; e_version
        dq _start      ; e_entry (entry point address)
        dq phdr - $$   ; e_phoff (program header offset)
        dq 0           ; e_shoff (section header offset)
        dd 0           ; e_flags (processor-specific flags)
        dw ehdrsize    ; e_ehsize (elf header size)
        dw phdrsize    ; e_phentsize (program header size)
        dw 1           ; e_phnum (number of program header entries)
        dw 0           ; e_shentsize (size of section header entry)
        dw 0           ; e_shnum (number of section header entries)
        dw 0           ; e_shstrndx (section name string table index)

ehdrsize equ $ - ehdr

phdr:
        dd 1           ; p_type (loadable segment)
        dd 5           ; p_flags (segment attributes)
        dq 0           ; p_offset (offset in file)
        dq $$          ; p_vaddr (virtual address in memory)
        dq phdr        ; p_paddr (reserved)
        dq filesize    ; p_filesz (size of segment in file)
        dq filesize    ; p_memsz (size of segment in memory)
        dq 0x1000      ; p_align (alignment of segment)

phdrsize equ $ - phdr

_start:
	xor rax, rax
	inc rax
	xor rdi, rdi
	inc rdi
        mov rsi, msg
        mov rdx, 13
        syscall
        mov rax, 60
        xor dil, dil
        syscall
msg:    db  "Hello, World", 10

filesize equ $ - $$

