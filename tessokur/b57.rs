use fmt::Debug;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, k): (usize, usize) = read_two(&mut lines);

    let mut dp = vec![vec!(0; n + 1); 32];

    for i in 0..=n {
        dp[0][i] = sub(i);
    }

    for i in 1..32 {
        for j in 0..=n {
            dp[i][j] = dp[i - 1][dp[i - 1][j]];
        }
    }

    let mut result: Vec<_> = (0..=n).collect();

    for i in 0..32 {
        if k & 1 << i > 0 {
            for j in 0..=n {
                result[j] = dp[i][result[j]];
            }
        }
        if 1 << i > k {
            break;
        }
    }

    for i in 1..=n {
        println!("{}", result[i]);
    }
}

fn sub(v: usize) -> usize {
    let mut total = 0;
    let mut acc = v;

    while acc > 0 {
        total += acc % 10;
        acc /= 10;
    }

    assert!(total <= v, "Total is greater than the input value");
    v - total
}

fn read_two<A: str::FromStr, B: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> (A, B)
where
    A::Err: Debug + 'static,
    B::Err: Debug + 'static,
{
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: A = parts.next().unwrap().parse().unwrap();
    let b: B = parts.next().unwrap().parse().unwrap();
    (a, b)
}
