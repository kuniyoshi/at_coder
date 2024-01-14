use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let _: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    // 残り一山は勝ち状態
    // 残り二山なら合計が奇数なら勝ち状態
    // 7 7
    // 1: 6 7
    // 2: 5 7
    // 1: 4 7
    // 2: 3 7
    // 1: 2 7
    // 2: 1 7
    // 1: 1 6
    // 2: 1 5
    // 1: 1 4
    // 2: 1 3
    // 1: 1 2
    // 2: 1 1

    let mut xor: usize = 0;

    for a in a.iter() {
        xor ^= a;
    }

    println!("{}", if xor > 0 { "First" } else { "Second" });
}