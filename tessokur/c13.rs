use std::io::{self, BufRead};

static MOD: usize = 1_000_000_007;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, p): (usize, usize) = {
        let list: Vec<usize> = lines
            .next()
            .unwrap()
            .unwrap()
            .split_whitespace()
            .map(|s| s.parse().unwrap())
            .collect();
        (list[0], list[1])
    };
    let a: Vec<usize> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse::<usize>().unwrap() % MOD)
        .collect();

    let mut count: usize = 0;

    for i in 0..n {
        for j in 0..i {
            if (a[i] * a[j]) % MOD == p {
                count += 1;
            }
        }
    }

    println!("{}", count);
}
