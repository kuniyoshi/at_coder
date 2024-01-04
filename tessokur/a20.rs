use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();
    let t: Vec<char> = lines.next().unwrap().unwrap().chars().collect();

    //  tokyo
    //  kyoto
    // 000000
    // 000010 <- t
    // 001112 <- o
    // 001222 <- k
    // 011222 <- y
    // 011223 <- o

    let mut dp: Vec<Vec<usize>> = vec![vec![0; t.len() + 1]; s.len() + 1];

    for i in 1..=s.len() {
        for j in 1..=t.len() {
            dp[i][j] = dp[i - 1][j].max(dp[i - 1][j - 1] + if t[j - 1] == s[i - 1] { 1 } else { 0 }).max(dp[i][j - 1]);
        }
    }

    // eprintln!("{:?}", dp);
    println!("{}", dp[s.len()][t.len()]);
}