#!/usr/bin/env bash
set -euo pipefail

{

#  0
# ELF header: magic number
printf "\x7fELF"
#  4
# ELF header: 2 = 64 bit
printf "\x02"
#  5
# ELF header: 1 = little endian
# binary: program start
# 31c0 xor eax, eax
printf "\x31"
#  6
# ELF header: ELF header version
printf "\xc0"
#  7
# ELF header: OS ABI, usually 0
# binary:
# ffc0 inc eax (select syscall 1 (write))
printf "\xff"
#  8
# ELF header: unused/padding
printf "\xc0"
#  9
# ELF header: unused/padding
# binary:
# be 48 00 01 00 mov esi, 0x10048 (buf addr for write)
printf "\xbe\x48\x00"
#  c
# ELF header: unused/padding
printf "\x01\x00"
#  e
# ELF header: unused/padding
# binary: eb18 = jmp 23 (0x10 + 23 (0x18) = 0x28)
printf "\xeb\x18"
# 10
# ELF header: type (2 = executable)
printf "\x02\x00"
# 12
# ELF header: instruction set (0x3e = x86-64)
printf "\x3e\x00"
# 14
# ELF header: ELF version (currently 1)
# binary (jumped here from 0x34):
# ffcf dec edi
# 0f05 syscall
printf "\xff\xcf\x0f\x05"
# 18
# ELF header: program entry offset
printf "\x05\x00\x01\x00\x00\x00\x00\x00"
# 20
# ELF header: program header table offset
printf "\x30\x00\x00\x00\x00\x00\x00\x00"
# 28
# ELF header: section header table offset
# binary (jumped here from 0xe):
# 89c7 mov edi, eax
# 31d2 xor edx, edx
# b20c mov dl, 0xe (14 bytes)
# eb30 jmp 0x30 (to 0x60)
printf "\x89\xc7\x31\xd2\xb2\x0e\xeb\x30"
# 30
# ELF header: flags (unused)
# ELF program header: type of segment: 1 (load: clear p_memsz bytes at p_vaddr
#     to 0, then copy p_filesz bytes from p_offset to p_vaddr)
printf "\x01\x00\x00\x00"
# 34
# ELF header: ELF header size
# ELF program header: flags (1 = executable, 4 = readable, 5 = r+x)
printf "\x05\x00"
# 36
# ELF header: program header tbl entry size
# ELF program header: flags cont'd
printf "\x38\x00"
# 38
# ELF header: number of entries in program header tbl
# ELF program header: p_offset: offset for data in this segment
printf "\x01\x00"
# 3a
# ELF header: section header tbl entry size
# ELF program header: p_offset cont'd
printf "\x00\x00"
# 3c
# ELF header: number of entries in section header tbl
# ELF program header: p_offset cont'd
printf "\x00\x00"
# 3e
# ELF header: section idx to section hdr tbl
# ELF program header: p_offset cont'd
printf "\x00\x00"
# 40
# end of ELF header
# ELF program header: p_vaddr: where should this segment be put in virtual memory
printf "\x01\x00\x01\x00\x00\x00\x00\x00"
# 48
# ELF program header: p_paddr: reserved for the segment's physical address
printf "Hello, w"
# 50
# ELF program header: p_filesz: size of segment in the file
printf "orld!\n\x00\x00"
# 58
# ELF program header: p_memsz: size of segment in memory, >=p_filesz
printf "orld!\n\x00\x00"
# 60
# ELF program header: the required alignment for this section, usually a power of 2
# binary (jumped here from 0x30):
# 0f05 syscall
# 31c0 xor eax, eax
# b03c mov al, 0x3c (60, exit syscall)
# dbac jmp 0xac (backwards jump by 0x54, to 0x68-0x54=0x14)
printf "\x0f\x05\x31\xc0\xb0\x3c\xeb\xac"

} >a.out
chmod +x a.out
