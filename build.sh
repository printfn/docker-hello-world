#!/bin/bash

set -euo pipefail

cd hello-world
cargo +nightly build --target x86_64-unknown-linux-musl --release
cd ..
strip hello-world/target/x86_64-unknown-linux-musl/release/hello-world
docker build --tag printfn/hello-world .
stat --format="Binary size: %s" hello-world/target/x86_64-unknown-linux-musl/release/hello-world
docker image inspect printfn/hello-world:latest -f "Image size: {{ json .Size }}"
docker run --rm printfn/hello-world
