#!/bin/bash

set -euo pipefail

cd hello-world
cargo +nightly build --target x86_64-unknown-linux-musl --release
cd ..
docker build --tag printfn/hello-world .
docker run --rm printfn/hello-world
