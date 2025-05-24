#!/usr/bin/env bash
set -euo pipefail
./x86-64.sh
docker build . --file Dockerfile.x86-64 -t printfn/hello-world:amd64 --platform linux/amd64
./aarch64.sh
docker build . --file Dockerfile.aarch64 -t printfn/hello-world:arm64 --platform linux/arm64
docker push printfn/hello-world:amd64
docker push printfn/hello-world:arm64
docker manifest create printfn/hello-world --amend printfn/hello-world:amd64 --amend printfn/hello-world:arm64
docker manifest push printfn/hello-world:latest
