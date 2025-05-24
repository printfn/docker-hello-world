FROM --platform=linux/amd64 scratch
ADD a.out /
CMD ["/a.out"]
