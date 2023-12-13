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
            let line = lines.next().unwrap().unwrap();
            // eprintln!("{:?}", line);
            let list: Vec<usize> = line
                .split_whitespace()
                .map(|s| s.parse().unwrap_or_else(|_| panic!("error: {}", s)))
                .collect();
            bits3(list[0], list[1], list[2])
        })
        .collect();

    // eprintln!("{:?}", switches);

    let mut dp: Vec<Vec<Option<usize>>> = vec![vec![None; 1 + 1 << n]; m + 1];
    dp[0][bits(&a)] = Some(0);

    for i in 0..m {
        for j in 0..dp[i].len() {
            match dp[i][j] {
                Some(v) => {
                    dp[i + 1][j] = Some(dp[i + 1][j].map_or_else(|| v, |x| x.min(v)));
                    dp[i + 1][j ^ switches[i]] =
                        Some(dp[i + 1][j ^ switches[i]].map_or_else(|| v + 1, |x| x.min(v + 1)));
                }
                None => (),
            };
        }
    }

    // for i in 0..dp.len() {
    //     for j in 0..dp[i].len() {
    //         match dp[i][j] {
    //             Some(v) => println!(" {} {} -> {}", i, format!("{:b}", j), v),
    //             None => (),
    //         }
    //     }
    // }

    match dp[m][(1 << n) - 1] {
        Some(c) => println!("{}", c),
        None => println!("{}", -1),
    };
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
