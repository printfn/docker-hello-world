; hello-world.asm
bits 64
global _start

section .text
_start:
	xor rax, rax
	inc rax       ; 'write' syscall has code 1
	xor rdi, rdi
	inc rdi       ; write to file descriptor 1 (stdout)
        mov rsi, msg  ; addr of message
        mov rdx, 13   ; length of message
        syscall       ; perform syscall
        mov rax, 60   ; code for 'exit' syscall
        xor dil, dil  ; exit code 0
        syscall       ; perform exit call
msg:    db  "Hello, World", 10

