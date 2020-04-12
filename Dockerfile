FROM scratch
ADD hello-world/target/x86_64-unknown-linux-musl/release/hello-world /
CMD ["/hello-world"]
