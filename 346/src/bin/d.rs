use std::io::{self, BufRead};

// struct P {
//     unused: (Option<usize>, Option<usize>),
//     used: (Option<usize>, Option<usize>),
// }

// impl P {
//     fn next(self, value: usize) -> P {
//         todo!()
//     }
// }

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
    let mut dp: Vec<Vec<usize>> = vec![vec![infinity, infinity, infinity, infinity]; n];

    if s[0] == '0' {
        dp[0][0] = 0;
        dp[0][1] = c[0];
    }
    else {
        dp[0][0] = c[0];
        dp[0][1] = 0;
    }

    // 00011
    for i in 1..n {
        match s[i] {
            '0' => {
                dp[i][0] = dp[i - 1][1];
                dp[i][1] = dp[i - 1][0] + c[i];
                dp[i][2] = dp[i - 1][0].min(dp[i - 1][3]);
                dp[i][3] = (dp[i - 1][1] + c[i]).min(dp[i - 1][2] + c[i]);
            }
            '1' => {
                dp[i][0] = dp[i - 1][1] + c[i];
                dp[i][1] = dp[i - 1][0];
                dp[i][2] = (dp[i - 1][3] + c[i]).min(dp[i - 1][0] + c[i]);
                dp[i][3] = dp[i - 1][1].min(dp[i - 1][2]);
            },
            _ => unreachable!()
        }
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", dp);

    println!("{}", dp[n - 1][2].min(dp[n - 1][3]));
}
