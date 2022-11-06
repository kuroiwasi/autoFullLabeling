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

set -e # エラー時に停止

# コーパスのパス
jsut_corpus="./corpus/BASIC5000.txt"
# コーパスの文章数
list_row=1
# 音声ファイルのパス
wav_file="./wav/"

# ディレクトリをリフレッシュ
root_of_labels="./output_files/labels"
root_of_logfiles="./output_files/log"
refresh_dir=("${root_of_labels}/" "${root_of_logfiles}/" "./tools/segmentation-kit/wav/")  
for index in ${refresh_dir[@]}; do
    if [ -d ${index} ]; then rm -rf ${index}; fi
    mkdir ${index}
done
## ラベル用ディレクトリを作成
step_dir=("${root_of_labels}/00" "${root_of_labels}/01_時間情報削除済みラベル/" \
"${root_of_labels}/02_ローマ字台本/" "${root_of_labels}/03_新時間情報モノフォンラベル/" \
"${root_of_labels}/04_時間情報のみ/" "${root_of_labels}/05_時間情報付きフルコンテキストラベル/")
for index in ${step_dir[@]}; do mkdir ${index}; done
## rログ用ディレクトリを作成
log_file=("${root_of_logfiles}/00_configure.log" "${root_of_logfiles}/00_make.log" \
"${root_of_logfiles}/04_segment.log")

dir_of_scripts="./scripts/src" # スクリプトの保存場所

# step 1: 台本からフルコンテキストラベルに変換
echo "step 1: 台本をフルコンテキストラベルに変換"
python3 ${dir_of_scripts}/台本をフルコンテキストラベルに変換.py ${list_row} ${jsut_corpus} ${step_dir[1]}

# step 2: julius 用のローマ字台本ファイル作成
echo "step 2: julius 用のローマ字台本ファイル作成"
python3 ${dir_of_scripts}/台本を漢字からローマ字に変換.py ${list_row} ${jsut_corpus} ${step_dir[2]}

# step 3: julius を利用した強制音素アライメント
echo "step 3: julius を利用した強制音素アライメント"
cp ${step_dir[2]}/* ./tools/segmentation-kit/wav/ # ローマ字台本をコピー
python3 ${dir_of_scripts}/音声ファイルをレート調整してコピー.py ${list_row} ${wav_file}  # 音声ファイルをコピー
# 強制音素アライメントの生成
cd ./tools/segmentation-kit/
perl ./segment_julius.pl >> ../../${log_file[2]} 2>&1
cd ../../
# 生成されたデータをコピー
cp ./tools/segmentation-kit/wav/*.lab ${step_dir[3]}

# step 4: 音素アライメントから時間情報の抽出
echo "step 4: 音素アライメントから時間情報の抽出"
python3 ${dir_of_scripts}/モノフォンラベルから時間情報の削除.py ${list_row} ${step_dir[3]} ${step_dir[4]}

# step 5: 新時間情報つきフルコンテキストラベルの作成
echo "step 5: 新時間情報付きフルコンテキストラベルの作成"
python3 ${dir_of_scripts}/ファイルの結合.py ${list_row} ${step_dir[1]} ${step_dir[4]} ${step_dir[5]}
