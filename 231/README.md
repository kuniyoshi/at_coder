# 結果

| 問題 | 結果 | 提出時間            | かかった時間 |
|------|------|---------------------|--------------|
| A    | AC   | 2021-12-11 21:01:34 | 2 min        |
| B    | AC   | 2021-12-11 21:07:36 | 6 min        |
| C    | AC   | 2021-12-11 21:30:41 | 23 min       |
| D    | AC   | 2021-12-11 22:34:02 | 64 min       |
| E    | -    | -                   |     min      |

# A

## 振り返り

特にありません。

## 解説をみたあと

特にありません。

# B

## 振り返り

ちょっと手こずりました。シュワルツ変換。

## 解説をみたあと

特にありません。

# C

## 振り返り

二分探索でやりました。次に二分探索の問題が出たら
解けるって思ってたので良かったです。ac, wa, wj で
書けるようになりました。

昇順でみていきましたが、降順の方がいいんじゃないか
って思いながら書いていました。

## 解説を見たあと

wa, ac が解説と逆でした。
二分探索で合ってたようです。

# D

## 振り返り

なんとか AC できました。でも汚いコードになってしまいました。

下記のように考えました。

- 隣り合うものを見つけたらそれを決定しておく
- 左右それぞれについて、それの隣を探す
- 隣に配置する、だたし、すでに配置済みだったらエラーとする

見つけ方は早めにわかりましたが、コードにするのに時間が
かかりました。

## 解説を見たあと

Union-Find が使えたようです。コンテスト中に検討したはずですが
使えないって思ってしまいました。

条件を見落としていました。(1, 2), (1, 2) は入力としてありえなくて、
(1, 2), (2, 1) も入力としてありえないですね。

結合が 3 以上のものは Union-Find に入らないことで、クエリは
必ずグループの端を選択している、という条件が成り立つんですね。

# E

## 解説を見たあと