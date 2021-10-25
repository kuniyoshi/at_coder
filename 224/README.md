# 結果

| 問題 | 結果 | 提出時間            | かかった時間 |
|------|------|---------------------|--------------|
| A    | AC   | 2021-10-23 21:02:08 | 2 min        |
| B    | AC   | 2021-10-23 21:12:22 | 10 min       |
| C    | -    | -                   |     min      |
| D    | -    | -                   |     min      |
| E    | -    | -                   |     min      |

# A

## 振り返り

perl だと楽です。

## 解説をみたあと

# B

## 振り返り

ちょっと面倒ですが、言われた通り愚直にやりました。

## 解説をみたあと

# C

## 振り返り

まず正の面積でひっかかりました。負の面積ってなんだろうと思いました。
面積が 0 ではない、ということなんじゃないかと思いましたが、
最後まで違うパタンがあるだろうかって考えることがありました。

正の面積である、を一直線上にない、と同じこととして考えました。

途中で場合分けが面倒になったので、最初に原点からのマンハッタン距離で
並べ替えることで前提を置けるようにしました。

3 重ループで全組み合わせを試す方法にしました。

一直線上にない、ということを、二点から直線予想で三点目を出したときに
本当の三点目と一致しない、ということとして考えていました。

点 a, b, c として、ab の傾きと bc の傾きとが等しければ直線にある、
と言えそうですが浮動小数だと WA すると思ったので整数で同じことが
できないかと考えていました。

コンテスト時間後も考えましたが、思いつきませんでした。

## 解説を見たあと

# D

## 解説を見たあと

# E

## 解説を見たあと