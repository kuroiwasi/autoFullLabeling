# これはなに
これは [ttslearn](https://github.com/r9y9/ttslearn) を用いた DNNTTS 学習のために必要な時間情報付きフルコンテキストラベルを Julius と pyopenjtalk を使って、コーパス (台本) と音声から生成するプログラムです。
# 動作確認環境
* Ubuntu 22.04.1 LTS x86_64
  * Docker version 20.10.17
  * Docker Compose version 2.5.0
* macOS 12.6.1 21G217 arm64
  * colima version 0.4.6
  * Docker version 20.10.20
  * Docker Compose version 2.12.2
# どうやって使うの
`wav/` に `BASIC5000_xxxx.wav` の形式で wav ファイルを配置してから，DNNTTS with YourVoice のディレクトリに移動して OS に対応する以下のコマンドを実行してください。 xxxx には対応する台本の番号が入ります。<br>
ex. 123 番の台本の場合: `BASIC5000_0123.wav`
## 実行
```bash
HOSTUID=$(id -u) HOSTGID=$(id -g) docker compose up --build
```

これにより `output/` に音素境界付きフルコンテキストラベルと音声が出力されます。
# 謝辞
このプログラムは以下のプログラム等を利用することで動作しています．<br>
各製作者の方々，有難うございます．<br>
* [Julius](https://julius.osdn.jp/index.php?q=newjulius.html): `tools/segmentation-kit/bin/julius/julius-4.6`
* [音素セグメンテーションキット](https://julius.osdn.jp/index.php?q=ouyoukit.html): `tools/segmentation-kit/`
* [JSUT コーパス](https://sites.google.com/site/shinnosuketakamichi/publication/jsut): `corpus/BASIC5000.txt`
