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
import pyopenjtalk as poj

def func(input_path, output_dir):
    with open(input_path, 'rt') as input_file:
        # 台本データの読み込み
        lines = input_file.readlines()
        for line in lines:
            name, text = line.replace('\n', '').split(':')

            # 出力ファイルの設定
            output_path = f"{output_dir}/{name}.lab"
            # フルコンテキストラベルの生成
            full_labels = poj.extract_fullcontext(text)
            # ラベルデータの書き出し
            output_str = '\n'.join(full_labels) # 1 次元配列を改行文字列に変換
            with open(output_path, 'wt') as output_file:
                output_file.write(output_str) # 書き出し

if __name__ == '__main__':
    func(sys.argv[1], sys.argv[2])