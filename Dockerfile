FROM --platform=linux/amd64 scratch
ADD x86-64.out /
CMD ["/x86-64.out"]
