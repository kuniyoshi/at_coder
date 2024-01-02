use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, s): (usize, usize) = {
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

    let mut dp: Vec<bool> = vec![false; s + 1];
    dp[0] = true;

    for i in 0..n {
        for j in (a[i]..=s).rev() {
            if dp[j - a[i]] {
                dp[j] = true;
            }
        }
    }

    eprintln!("{:?}", dp);
    println!("{}", if dp[s] { "Yes" } else { "No" });
}
