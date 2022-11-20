#!/bin/bash
set -e # エラー時に停止させる

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

### ここは実行前に設定する変数 ###

# コーパスファイル名
corpus="BASIC5000.txt"
# コーパスの文章数
list_row=5000

############################################################
### ここから下は触ると大変なことになるかもだから触るなら心して触れ ###
############################################################

corpath="./src/corpus/${corpus}"
wav_file="./wav"                              # 音声ファイルのパス
root_of_labels="./temp/labels"                # ラベルフォルダのルート
root_of_logfiles="./temp/log"                 # ログフォルダのルート
segment_kit="./src/segmentation-kit"          # 音素セグメンテーションキット
modded_wav="${segment_kit}/wav"               # レート調整された音声ファイル
dir_of_scripts="./src/bin"                    # スクリプトの保存フォルダ
output_dir="./output"                         # 最終結果の保存場所

# ディレクトリをリフレッシュ
refresh_dir=("${root_of_labels}" "${root_of_logfiles}" "${segment_kit}/wav" \
"${output_dir}/wav ${output_dir}/lab" "${modded_wav}")  
for index in ${refresh_dir[@]}; do
    if [ -d ${index} ]; then rm -rf ${index}; fi
    mkdir -p ${index}
done

# ラベル用ディレクトリを作成
step_dir=("${root_of_labels}/00" "${root_of_labels}/01_時間情報削除済みラベル" \
"${root_of_labels}/02_ローマ字台本" "${root_of_labels}/03_新時間情報モノフォンラベル" \
"${root_of_labels}/04_時間情報のみ" "${root_of_labels}/05_時間情報付きフルコンテキストラベル")
for index in ${step_dir[@]}; do mkdir ${index}; done

# ログの保存先パスを設定
log_file=("${root_of_logfiles}/00_configure.log" "${root_of_logfiles}/00_make.log" \
"${root_of_logfiles}/04_segment.log")

# gitkeep の追加
touch output/.gitkeep
touch temp/.gitkeep
touch wav/.gitkeep

# コーパス -> 時間情報なしフルコンテキストラベル
echo "step 1: 台本をフルコンテキストラベルに変換"
python3 ${dir_of_scripts}/Kanji2Full.py ${list_row} ${corpath} ${step_dir[1]}

# コーパス -> ローマ字ファイル
echo "step 2: julius 用のローマ字台本ファイル作成"
python3 ${dir_of_scripts}/Kanji2Roma.py ${list_row} ${corpath} ${step_dir[2]}

# 録音音声 & ローマ字ファイル -> 時間情報ありモノフォンラベル
echo "step 3: julius を利用した強制音素アライメント"
## データのコピー
cp ${step_dir[2]}/* ${segment_kit}/wav # ローマ字台本をコピー
python3 ${dir_of_scripts}/Change_Rate.py ${list_row} ${wav_file} ${modded_wav} # 音声ファイルをコピー
## 強制音素アライメントの生成をサブシェルで実行
(cd ${segment_kit}; perl segment_julius.pl) >> ${log_file[2]} 2>&1
## 生成されたデータをコピー
cp ${segment_kit}/wav/*.lab ${step_dir[3]}

# 時間情報ありモノフォンラベル -> 時間情報のみ
echo "step 4: 音素アライメントから時間情報の抽出"
python3 ${dir_of_scripts}/Remove_Time.py ${list_row} ${step_dir[3]} ${step_dir[4]}

# 時間情報のみ & 時間情報なしフルコンテキストラベル -> 時間情報ありフルコンテキストラベル
echo "step 5: 時間情報ありフルコンテキストラベルの作成"
python3 ${dir_of_scripts}/Connect_Files.py ${list_row} ${step_dir[1]} ${step_dir[4]} ${step_dir[5]}

# output にファイルを出力
cp -RT ${step_dir[5]} ${output_dir}/lab
cp -RT ${wav_file} ${output_dir}/wav