#
# Super simple example of a Dockerfile
#
FROM ubuntu:latest
MAINTAINER Andy McNeill "andy.mcneill@bt.com"

RUN apt-get update
RUN apt-get install -y python python-pip wget
RUN pip install Flask

ADD processTHRecords.py /home/processTHRecords.py

WORKDIR /home
