#!/usr/bin/env bash
set -euo pipefail

{

#  0
# ELF header: magic number
printf "\x7fELF"
#  4
# ELF header: 2 = 64 bit
# binary: program start
# d2800020 mov x0, #1
printf "\x20"
#  5
# ELF header: 1 = little endian
printf "\x00"
#  6
# ELF header: ELF header version
printf "\x80"
#  7
# ELF header: OS ABI, usually 0
printf "\xd2"
#  8
# ELF header: unused/padding
# binary:
# d2820c01 mov x1, #0x1060
printf "\x01\x0c\x82\xd2"
#  c
# ELF header: unused/padding
# binary:
# 14000007 b #0x1c (jump to 0x28)
printf "\x07\x00\x00\x14"
# 10
# ELF header: type (2 = executable)
printf "\x02\x00"
# 12
# ELF header: instruction set (0xb7 = aarch64)
printf "\xb7\x00"
# 14
# ELF header: ELF version (currently 1)
# unused
printf "\x01\x00\x00\x00"
# 18
# ELF header: program entry offset
printf "\x04\x10\x00\x00\x00\x00\x00\x00"
# 20
# ELF header: program header table offset
printf "\x30\x00\x00\x00\x00\x00\x00\x00"
# 28
# ELF header: section header table offset
# binary (jumped here from 0xc):
# d28001c2 mov x2, #14
# 14000007 b #0x1c (jump to 0x70)
printf "\xc2\x01\x80\xd2"
printf "\x07\x00\x00\x14"
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
printf "\x01\x10\x00\x00\x00\x00\x00\x00"
# 48
# ELF program header: p_paddr: reserved for the segment's physical address
# binary (jumped here from 0x2c):
# d2800808 mov x8, #64 (syscall number for write)
# d4000001 svc #0 (syscall)
printf "\x08\x08\x80\xd2"
printf "\x01\x00\x00\xd4"
# 50
# ELF program header: p_filesz: size of segment in the file
# binary:
# 14000008 b #0x20 (jump to 0x70)
printf "\x08\x00\x00\x14\x00\x00\x00\x00"
# 58
# ELF program header: p_memsz: size of segment in memory, >=p_filesz
printf "\x08\x00\x00\x14\x00\x00\x00\x00"
# 60
# ELF program header: the required alignment for this section, usually a power of 2
printf "Hello, w"
printf "orld!\n\x00\x00"
# 70
# binary:
# d2800000 mov x0, #0
# d2800ba8 mov x8, #93 (exit syscall)
# d4000001 svc #0
printf "\x00\x00\x80\xd2"
printf "\xa8\x0b\x80\xd2"
printf "\x01\x00\x00\xd4"

} >aarch64.out
chmod +x aarch64.out
