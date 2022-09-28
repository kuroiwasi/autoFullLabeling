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

def num2index(num): # 数字を強制的に 4 桁にする
    if 0 <= num and num < 10:           return '000' + str(num)
    elif 10 <= num and num < 100:       return '00' + str(num)
    elif 100 <= num and num < 1000:     return '0' + str(num)
    elif 1000 <= num and num <= 5000:   return str(num)
    else:                               return 'error'