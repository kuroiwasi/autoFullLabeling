FROM python:3.9
USER root
RUN apt-get update

# Set environment variable
ENV TERM=xterm

# Install library from pip
RUN apt-get install -y cmake
COPY requirements.txt /root/
RUN pip install -r /root/requirements.txt

# Install software from apt-get
RUN apt-get install -y git
