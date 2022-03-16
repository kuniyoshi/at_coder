# 結果

| 問題 | 結果 | 提出時間            | かかった時間 |
|------|------|---------------------|--------------|
| A    | AC   | 2022-02-05 21:01:45 | 2 min        |
| B    | AC   | 2022-02-05 21:15:40 | 15 min       |
| C    | AC   | 2022-02-05 22:10:32 | 55 min       |
| D    | -    | -                   |     min      |
| E    | -    | -                   |     min      |

# A

## 振り返り

特にありません。

## 解説をみたあと

全然ダメなやり方でした。2^n の方が Inf になるので
AC にはなってました。

今度からはちゃんと条件見ていきます。

# B

## 振り返り

難しかったです。今回はやばそうだなと思いました
(前回が易し目だったので予想はしてましたけど) 。

2 周する、というのはやったことがあるので使いました。

## 解説をみたあと

2 周する必要はありませんでした。360 が必ずあるだけで
よかったんですね。

# C

## 振り返り

難しかったです。D は挑戦する時間すらなさそうだなと思いました。

数式に手こずっていました。

入力例が優しかったので mod 必要なところが分かりました。
最高桁が 10 あったらオーバフローしますね。

## 解説を見たあと

変なやり方したかと思いましたが、意外とちゃんとできていました。

mod したら割り切れない可能性が出てくる、というのは
気づいていませんでした。今回は問題なかったようです。

あと変な解き方がありました。xor は桁上がりのない足し算、
ちょっと前の解説でありましたね。全然気づかなかったし
今もわかってません。

# D

## 解説を見たあと

解説を見ても分かりませんでした。下の 2 つです。

- s - x - y > 0 でないといけない
- s - x - y の 1 ビット目が 1 でないといけない

# E

## 振り返り

ちょっとだけ挑戦しました。ダメ元ですけど。

今回は累積和じゃないなって思いました。でも累積和だったようです。

## 解説を見たあと

面白かったです。

- 最後が分かればいい
- 最後の塊の手前まで分かればいい

というところまでは分かりそうですが、その後が繋がってなくて
飛躍が求められた感じです。