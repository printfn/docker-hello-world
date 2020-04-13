# tiny hello world

`00-rust` is a normal Rust Hello World program in Rust, using default settings to create a standalone Docker image (size: 2,898,392 bytes)

`01-rust` uses `no_std` and a few other tricks to reduce the size of the Rust program to 13360 bytes.

`02-asm` uses nasm and ld to achieve a size of 4360 bytes.

`03-asm` uses nasm to manually create a standard ELF file, using 157 bytes.

`04-asm` breaks the ELF spec in various ways to create a 112-byte executable.

View disassembly using `objdump -b binary -m i386:x86-64 -D a.out`.

