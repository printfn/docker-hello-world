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
printf "\x31"
#  6
# ELF header: ELF header version
printf "\xc0"
#  7
# ELF header: OS ABI, usually 0
printf "\xff"
#  8
# ELF header: unused/padding
printf "\xc0\xbe\x50\x00"
#  c
# ELF header: unused/padding
printf "\x01\x00\xeb\x18"
# 10
# ELF header: type (2 = executable)
printf "\x02\x00"
# 12
# ELF header: instruction set (0x3e = x86-64)
printf "\x3e\x00"
# 14
# ELF header: ELF version (currently 1)
printf "\xff\xcf\x0f\x05"
# 18
# ELF header: program entry offset
printf "\x05\x00\x01\x00\x00\x00\x00\x00"
# 20
# ELF header: program header table offset
printf "\x38\x00\x00\x00\x00\x00\x00\x00"
# 28
# ELF header: section header table offset
printf "\x89\xc7\x31\xd2\xb2\x0c\x0f\x05"
# 30
# ELF header: flags (unused)
printf "\x31\xc0\xb0\x3c"
# 34
# ELF header: ELF header size
printf "\xeb\xde"
# 36
# ELF header: program header tbl entry size
printf "\x38\x00"
# 38
# ELF header: #entries in program header tbl
# ELF program header: type of segment: 1 (load: clear p_memsz bytes at p_vaddr
#     to 0, then copy p_filesz bytes from p_offset to p_vaddr)
printf "\x01\x00"
# 3a
# ELF header: section header tbl entry size
# ELF program header: type of segment cont'd
printf "\x00\x00"
# 3c
# ELF header: #entries in section header tbl
# ELF program header: flags (1 = executable)
printf "\x01\x00"
# 3e
# ELF header: section idx to section hdr tbl
# ELF program header: flags cont'd
printf "\x00\x00"
# 40
# end of ELF header
# ELF program header: p_offset: offset for data in this segment
printf "\x00\x00\x00\x00\x00\x00\x00\x00"
# 48
# ELF program header: p_vaddr: where should this segment be put in virtual memory
printf "\x00\x00\x01\x00\x00\x00\x00\x00"
# 50
# ELF program header: p_filesz: size of segment in the file
printf "\x48\x65\x6c\x6c\x6f\x20\x57\x6f"
# 58
# ELF program header: p_memsz: size of segment in memory, >=p_filesz
printf "\x72\x6c\x64\x0a\x00\x00\x00\x00"
# 60
# ELF program header: the required alignment for this section
printf "\x72\x6c\x64\x0a\x00\x00\x00\x00"
# 68
# # end of ELF program header
printf "\x01\x00\x00\x00\x00\x00\x00\x00"

} >a.out
