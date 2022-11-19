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

import csv
import sys
import numpy as np

def func(list_row, label_dir, time_dir, output_dir):
    for i in range(1, int(list_row)+1):
        # 入出力ファイル名を設定
        label_path  = f"{label_dir}/{i:04}.lab"
        time_path   = f"{time_dir}/{i:04}.lab"
        output_path = f"{output_dir}/BASIC5000_{i:04}.lab"

        with open(label_path, 'rt') as label_file:
            with open(time_path, 'rt') as time_file:
                # 各種データの読み込み
                time_array = np.array(list(csv.reader(time_file, delimiter = ' ')))   # time データを 2 次元配列に格納
                label_array = np.array(list(csv.reader(label_file, delimiter = ' '))) # label データを 2 次元配列に格納
                array = np.concatenate([time_array, label_array], axis=1)             # time と label を横に結合
                # ラベルデータの書き出し
                with open(output_path, 'wt') as output_file:
                    writer = csv.writer(output_file, delimiter=' ', lineterminator='\n')
                    writer.writerows(array)

if __name__ == '__main__':
    func(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4])
