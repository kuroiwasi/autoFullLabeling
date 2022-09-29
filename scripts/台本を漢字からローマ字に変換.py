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

import pyopenjtalk as poj
import num2index as n2i

def main():
    # 入力データの読み込み
    with open('./corpus/jsut_ver1.1/basic5000/transcript_utf8.txt', 'rt') as f:
        # 漢字台本データの読み込み
        array = f.read().split('\n') # 台本データを 1 次元配列に格納
        for i in range(5000):
            # 出力ファイル名を設定
            index = n2i.num2index(i + 1)
            output_path = './labels/02_ローマ字台本/BASIC5000_' + index + '.txt'
            # 台本をローマ字に変換
            kanji = array[i][15:]
            roma = poj.g2p(kanji, kana=False)
            # 動作が異なる記号の変換
            roma = roma.replace('pau', 'sp')
            roma = roma.replace('cl', 'q')
            roma = roma.replace('v', 'b')
            # ローマ字台本 (小文字) データの書き出し
            with open(output_path, 'wt') as g: g.write(roma.lower()) # 書き出し

if __name__ == "__main__":
    main()