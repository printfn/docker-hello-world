#!/bin/bash
set -euo pipefail

nasm -f elf64 hello-world.asm
ld -s hello-world.o
wc -c a.out
docker build --tag printfn/hello-world .
docker image inspect printfn/hello-world:latest -f "Image size: {{ json .Size }}"
docker run --rm printfn/hello-world:latest
