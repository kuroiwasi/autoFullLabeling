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

FROM python:3.9-slim-bullseye

USER root
# apt-get から追加ソフトウェアをインストール
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libasound2 \
    libpulse0 \
    libsndfile1 

# アクセス権周りの問題解消のために新規ユーザーを作成
ARG UID
ENV UID=${UID}
ARG GID
ENV GID=${GID}
RUN groupadd -g "${GID}" "user"
RUN useradd -u "${UID}" -g "${GID}" -m "user"
RUN chown -R user:user /home/user

USER user
WORKDIR /home/user
ARG HOME="/home/user"
# pip から Python ライブラリをインストール
COPY ./requirements.txt ${HOME}/requirements.txt
RUN pip install -r ${HOME}/requirements.txt
