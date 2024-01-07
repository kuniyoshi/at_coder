use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
    let b: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    let mut dp: Vec<i64> = vec![-1_000_000_000; n + 1];
    dp[1] = 0;

    for i in 1..n {
        dp[a[i - 1]] = dp[a[i - 1]].max(dp[i] + 100);
        dp[b[i - 1]] = dp[b[i - 1]].max(dp[i] + 150);
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", dp);

    println!("{}", dp[n]);
}