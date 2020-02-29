FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt -y upgrade \
    && apt install -y nghttp2

ENV DEBIAN_FRONTEND=dialog
