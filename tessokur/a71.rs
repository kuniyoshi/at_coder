use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let _ = lines.next().unwrap().unwrap();
    let mut a: Vec<usize> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();
    let mut b: Vec<usize> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();

    a.sort_by(|a, b| b.cmp(a));
    b.sort();

    let effort: usize = a.iter().zip(b.iter()).map(|(x, y)| x * y).sum();

    println!("{}", effort);
}
