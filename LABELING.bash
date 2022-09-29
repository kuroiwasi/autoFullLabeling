#!/bin/bash

:<<LISENCE
Copyright 2022 Fumiyoshi MATANO

This file is part of DNNTTS-With-YourVoice.

DNNTTS-With-YourVoice is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software Foundation,
either version 3 of the License, or (at your option) any later version.

DNNTTS-With-YourVoice is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with DNNTTS-With-YourVoice.
If not, see <https://www.gnu.org/licenses/>. 
LISENCE

# ディレクトリのリフレッシュ
refresh_dir=('./labels/' './tools/segmentation-kit/wav/' './tools/julius_bin/' './log/')  
for index in ${refresh_dir[@]}; do
    if [ -d ${index} ]; then rm -rf ${index}; fi
    mkdir ${index}
done
# 各ステップの出力保存場所の作成
step_dir=('00' './labels/01_時間情報削除済みラベル/' \
'./labels/02_ローマ字台本/' './labels/03_新時間情報モノフォンラベル/' \
'./labels/04_時間情報のみ/' './labels/05_時間情報付きフルコンテキストラベル')
for index in ${step_dir[@]}; do mkdir ${index}; done

# step 1: 台本からフルコンテキストラベルの取り出し
echo 'step 1: 台本からフルコンテキストラベの取り出し'
python3 ./scripts/台本をフルコンテキストラベルに変換.py

# step 2: julius 用のローマ字台本ファイル作成
echo 'step 2: julius 用のローマ字台本ファイル作成'
python3 ./scripts/台本を漢字からローマ字に変換.py

# step 3: julius を利用した強制音素アライメント
echo 'step 3: julius を利用した強制音素アライメント'
cp ./labels/03_ローマ字台本/* ./tools/segmentation-kit/wav/ # ローマ字台本をコピー
# julius (音声認識ソフトウェア) のビルド
cp -R ./tools/julius/* ./tools/julius_bin/ # コピーしてからビルドしたほうが管理が楽
cd ./tools/julius_bin/ && ./configure && make && cd ../../
python3 ./scripts/音声ファイルをレート調整してコピー.py # 音声ファイルをコピー
# 強制音素アライメントの生成
cd ./tools/segmentation-kit/
perl ./segment_julius.pl >> ../../log/04_segment.log 2>&1
cd ../../
# 生成されたデータをコピー
cp ./tools/segmentation-kit/wav/*.lab ./labels/04_新時間情報モノフォンラベル/

# step 4: 音素アライメントから時間情報の抽出
echo 'step 4: 音素アライメントから時間情報の抽出'
python3 ./scripts/モノフォンラベルから時間情報の削除.py

# step 5: 新時間情報つきフルコンテキストラベルの作成
echo 'step 5: 新時間情報付きフルコンテキストラベルの作成'
python3 ./scripts/ファイルの結合.py