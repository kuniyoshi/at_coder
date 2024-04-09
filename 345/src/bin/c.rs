use std::collections::HashMap;
use std::io::{self, BufRead}; // TODO: テンプレートに入れよう

fn main() {
    let mut lines = io::stdin().lock().lines();
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();

    let mut count = HashMap::new();

    for c in &s {
        *count.entry(c).or_insert(0) += 1;
    }

    let total = comb(s.len());
    let mut same = 0;

    for (_, c) in &count {
        same += comb(*c);
    }

    println!("{}", total - same + count.values().filter(|v| v > &&1).count().min(1));
}

fn comb(a: usize) -> usize {
    a * (a - 1) / 2
}