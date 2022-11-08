#!/usr/bin/env python3

"""
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
"""

import sys
import csv

list_row    = int(sys.argv[1])
input_dir   = str(sys.argv[2])
output_dir  = str(sys.argv[3])

for i in range(1, int(list_row)+1):
    # 入出力ファイル名を設定
    input_path  = f"{input_dir}/{i:04}.lab"
    output_path = f"{output_dir}/{i:04}.lab"

    with open(input_path, 'rt') as input_file:
        # ラベルデータの読み込み
        array = list(csv.reader(input_file, delimiter = ' ')) # label データを 2 次元配列に格納
        for row in array: del row[2] # ラベル情報 (3 列目) の削除
        # ラベルデータの書き出し
        with open(output_path, 'wt') as output_file:
            writer = csv.writer(output_file, delimiter=' ', lineterminator='\n')
            writer.writerows(array)
