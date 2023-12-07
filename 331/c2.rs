use std::cmp::Ordering;
use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let mut a: Vec<(usize, usize)> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .enumerate()
        .map(|(i, v)| (v, i))
        .collect();

    a.sort_by(|a, b| match b.0.cmp(&a.0) {
        Ordering::Equal => b.1.cmp(&a.1),
        other => other,
    });

    let mut acc: usize = 0;
    let mut result: Vec<usize> = vec![0; n];

    for i in 0..n {
        result[a[i].1] = acc;
        acc += a[i].0;
    }

    for i in 0..n {
        print!("{} ", result[i]);
    }

    println!("");
}
