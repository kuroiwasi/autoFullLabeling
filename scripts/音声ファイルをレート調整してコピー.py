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

import librosa
import soundfile as sf
import num2index as n2i

def main():
    for i in range(5000):
        # 入出力ファイル名を指定
        index = n2i.num2index(i + 1)
        input_path = './wav/BASIC5000_' + index + '.wav'
        output_path = './tools/segmentation-kit/wav/BASIC5000_' + index + '.wav'
        # sr: 16kHz, rate: 16bit の PCM 形式に音声を変換して出力
        y, sr = librosa.load(input_path, sr=16000, mono=True)
        sf.write(output_path, y, sr, subtype='PCM_16')

if __name__ == '__main__':
    main()