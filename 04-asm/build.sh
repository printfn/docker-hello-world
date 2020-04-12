#!/bin/bash
set -euo pipefail

nasm -f bin -o a.out hello-world.asm
chmod +x a.out
wc -c a.out
stat --format="Binary size: %s" a.out
docker build --tag printfn/hello-world .
docker image inspect printfn/hello-world:latest -f "Image size: {{ json .Size }}"
./a.out
docker run --rm printfn/hello-world

