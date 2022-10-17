## Copyright 2022 Fumiyoshi MATANO
##
## This file is part of DNNTTS-With-YourVoice.
##
## DNNTTS-With-YourVoice is free software: you can redistribute it and/or modify it under
## the terms of the GNU General Public License as published by the Free Software Foundation,
## either version 3 of the License, or (at your option) any later version.
##
## DNNTTS-With-YourVoice is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License along with DNNTTS-With-YourVoice.
## If not, see <https://www.gnu.org/licenses/>. 

FROM python:3.9-bullseye
USER root
RUN apt-get update

# Set environment variable
ENV TERM=xterm

# Install library from pip
RUN apt-get install -y cmake
COPY src/requirements.txt /root/
RUN pip install -r /root/requirements.txt

# Install software from apt-get
RUN apt-get install -y libsndfile1