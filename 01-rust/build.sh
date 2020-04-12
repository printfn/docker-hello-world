#!/bin/bash

set -euo pipefail

cargo +nightly build --target x86_64-unknown-linux-musl --release
strip target/x86_64-unknown-linux-musl/release/hello-world
stat --format="Binary size: %s" target/x86_64-unknown-linux-musl/release/hello-world
docker build --tag printfn/hello-world .
docker image inspect printfn/hello-world:latest -f "Image size: {{ json .Size }}"
docker run --rm printfn/hello-world
