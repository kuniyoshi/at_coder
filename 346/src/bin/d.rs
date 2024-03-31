use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();
    let c: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    let infinity = c.iter().sum::<usize>() + 1;

    // 0: 前が 0 で、連続を使っていないときのコストの最小値
    // 1: 前が 1 で、連続を使っていないときのコストの最小値
    // 2: 前が 0 で、連続を使ったあとのコストの最小値
    // 3: 前が 1 で、連続を使ったあとのコストの最小値
    let mut dp: Vec<Vec<usize>> = vec![vec![infinity, infinity, infinity, infinity]; n + 1];

    for i in 0..n {
        match s[i] {
            '0' => {
                // そのまま
                // 0 -> 0
                // 1 -> 0
                dp[i + 1][2] = dp[i][0].min(dp[i][3]);
                dp[i + 1][0] = dp[i][1];

                // フリップ
                // 0 -> 1
                // 1 -> 1
                dp[i + 1][1] = dp[i][0] + c[i];
                dp[i + 1][3] = (dp[i][2] + c[i]).min(dp[i][1] + c[i]);
            }
            '1' => {
                // そのまま
                // 0 -> 1
                // 1 -> 1
                dp[i + 1][1] = 
                dp[i + 1][3] = dp[i][1];


                // フリップ
                // 0 -> 0
                // 1 -> 0
            },
            _ => unreachable!()
        }
    }

    println!("{}", dp.last().unwrap().iter().min().unwrap());
}
