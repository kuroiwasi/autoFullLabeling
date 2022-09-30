# DNNTTS-with-YourVoice ver. 0.0.2
## これはなに
これは [ttslearn](https://github.com/r9y9/ttslearn) を用いた DNNTTS 学習のために必要な時間情報付きフルコンテキストラベルを、便利ツール (Julius と pyopenjtalk) を使って、台本 (JSUT コーパス - BASIC5000) とその台本を読み上げた音声から生成するプログラムです。<br>
動作確認は JSUT コーパス付属の音声を使って確かめたところ、ラベルの作成とそれを用いての合成音声生成までは確認しました。自分の声を用いての動作確認はまだしてないです、そのうちします。
## 作者の環境
Linux mint 20.3 edge
## どうやって使うの
### 事前準備
#### 外部ツール
以下のディレクトリ構造になるようにファイルをセットし、一部設定を変更して LABELING.bash を実行すれば O.K. です。必要なファイルはリンクをおいておくので各自解凍してセットしてください。<br>
- [JSUT コーパス](https://sites.google.com/site/shinnosuketakamichi/publication/jsut): /corpus/jsut_ver1.1/
- [Julius](https://julius.osdn.jp/index.php?q=newjulius.html): /tools/julius/
- [音素セグメンテーションキット](https://julius.osdn.jp/index.php?q=ouyoukit.html): /tools/segmentation-kit/
変更する必要がある設定: `segmentation-kit/segment_julius.pl` の `## julius executable` にある else 文のパスを `$juliusbin="../julius_bin/julius/julius";` に変更
#### Python ライブラリ
このプログラムは Python 上で実行するので、以下のライブラリが必要です。お好みのパッケージマネージャでインストールしてください。そのうち必要ライブラリをまとめた requirement.txt とか追加します。
- numpy
- librosa
- pysoundfile
- pyopenjtalk
### 録音データの配置
/wav/ に BASIC5000_xxxx.wav の形式で配置してください。 xxxx には対応する台本の番号が入ります。<br>
ex. 123 番の台本の場合: BASIC5000_0123.wav
### 実行

```
$ bash LABELING.bash
```

DNNTTS with YourVoice のルートディレクトリに移動して以上のコマンドを実行してください。そうすると `/labels/05_時間情報付きフルコンテキストラベル` に音素境界付きフルコンテキストラベルが出力されます。<br>

## 今後の予定
- 0.0.3: requirements.txt の追加
- 0.1.0: LABELING を bash から Python に移行
- 0.2.0: 必要な外部ソフトウェアを自動でダウンロードするように変更
- 1.0.0: ttslearn を用いて単体での TTS 実現
