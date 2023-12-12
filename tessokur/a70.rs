use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, m): (usize, usize) = {
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
        .map(|s| s.parse().unwrap())
        .collect();
    let switches: Vec<usize> = (0..m)
        .map(|_| {
            let list: Vec<usize> = lines
                .next()
                .unwrap()
                .unwrap()
                .split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect();
            bits3(list[0], list[1], list[2])
        })
        .collect();

    eprintln!("{:?}", switches);

    let mut dp: Vec<Vec<Option<usize>>> = vec![vec![None; 1 + 1 << n]; m + 1];
    dp[0][bits(&a)] = Some(0);
}

fn bits3(a: usize, b: usize, c: usize) -> usize {
    1 << (a - 1) | 1 << (b - 1) | 1 << (c - 1)
}

fn bits(a: &Vec<usize>) -> usize {
    let mut result: usize = 0;

    for i in 0..a.len() {
        result |= a[i] << i;
    }

    result
}

// 1 2 3 4
// 0 1 1 0
// o o o
//   o o o
