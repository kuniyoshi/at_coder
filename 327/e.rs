use fmt::Debug;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = read_one(&mut lines);
    let p: Vec<usize> = read_list(&mut lines);

    let mut dp: Vec<Vec<Option<f64>>> = vec!(vec!(None; n + 1); n + 1);
    dp[0][0] = Some(0_f64);

    for i in 1..=n {
        for j in 0..=n {
            dp[i][j] = max(dp[i - 1][j], dp[i][j]);
            if j + 1 < n {
                dp[i][j + 1] = max2(dp[i - 1][j], p[i - 1] as f64, dp[i][j + 1]);
            }
        }
    }

    let mut max: f64 = std::f64::MIN;

    for k in 1..=n {
        if let Some(dp_val) = dp[n][k] {
            max = fmax(
                max,
                dp_val / denominator(k) - 1200_f64.sqrt() / k as f64
            );
        } else {
            max = fmax(max, 1200_f64.sqrt() / k as f64);
        }
    }

    println!("{}", max);
}

fn denominator(k: usize) -> f64 {
    (1..=k).map(|i| 0.9_f64.powf((k - i) as f64)).sum()
}

fn max2(a: Option<f64>, b: f64, c: Option<f64>) -> Option<f64> {
    match (a, c) {
        (Some(a_val), Some(_)) => max(Some(a_val * 0.9 + b), c),
        (Some(a_val), None) => Some(a_val * 0.9 + b),
        (_, _) => c,
    }
}

fn max(a: Option<f64>, b: Option<f64>) -> Option<f64> {
    match (a, b) {
        (Some(a_val), Some(b_val)) => Some(fmax(a_val, b_val)),
        (None, _) => b,
        (_, None) => a,
    }
}

fn fmax(a: f64, b: f64) -> f64 {
    if a > b { a } else { b }
}

fn read_list<A: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> Vec<A>
where
    A::Err: Debug + 'static,
{
    let line = lines.next().unwrap().unwrap();
    line.split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect()
}

fn read_one<A: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> A
where
    A::Err: Debug + 'static,
{
    lines.next().unwrap().unwrap().parse().unwrap()
}
