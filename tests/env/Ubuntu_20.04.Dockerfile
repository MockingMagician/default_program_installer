FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install -y git fuse

RUN mkdir -p /home/root/.default_program_installer
WORKDIR /home/root/.default_program_installer
