FROM alpine:latest
RUN echo "This is my image!!" > /output.txt
CMD ["cat", "/output.txt"]
