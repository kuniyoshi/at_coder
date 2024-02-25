use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let stages: Vec<(usize, usize, usize)> = (0..(n-1)).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1], list[2])
    }).collect();

    let mut dp: Vec<Option<usize>> = vec![None; n];

    dp[0] = Some(0);

    for i in 0..stages.len() {
        let (a, b, x) = stages[i];
        dp[i + 1] = min(dp[i + 1], dp[i], a);
        dp[x - 1] = min(dp[x - 1], dp[i], b);
    }

    println!("{}", dp.last().unwrap().unwrap());
}

fn min(next: Option<usize>, currnet: Option<usize>, addition: usize) -> Option<usize> {
    match currnet {
        None => panic!("lower dp should exist"),
        Some(c) => {
            match next {
                None => return Some(c + addition),
                Some(n) => return Some(n.min(c + addition)),
            }
        }
    }
}