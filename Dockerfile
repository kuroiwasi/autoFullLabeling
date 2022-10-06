FROM python:3.9
USER root

# Set environment variable
ENV TERM=xterm

# Install library from pip
COPY requirements.txt /root/
RUN pip install -r /root/requirements.txt

# Install software from apt-get
RUN apt-get update
RUN apt-get install -y git
