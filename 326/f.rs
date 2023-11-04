use fmt::Debug;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (_, x, y): (usize, i32, i32) = read_three(&mut lines);
    let a: Vec<i32> = read_list(&mut lines);

    let (odds, evens) = split_odd_even(&a);

    println!("{}", yes_no(test(&odds, x) && test(&evens, y)));
}

fn test(values: &Vec<i32>, to: i32) -> bool {
    if values.len() == 0 {
        return to == 0;
    }

    let abs_max = values.iter().map(|v| v.abs()).sum::<i32>() as usize;

    let mut dp = vec!(vec!(false; abs_max * 2 + 1); values.len() + 1);
    dp[0][abs_max] = true;

    for i in 1..=values.len() {
        for j in 0..dp[i].len() {
            if !dp[i - 1][j] {
                continue;
            }

            let pj = j as i32 + values[i - 1];
            let nj = j as i32 - values[i - 1];

            if pj >= 0 && pj < dp[i].len() as i32 {
                dp[i][pj as usize] = true;
            }

            if nj >= 0 && nj < dp[i].len() as i32 {
                dp[i][nj as usize] = true;
            }
        }
    }

    if to < 0 && (to.abs() as usize) > abs_max {
        return false;
    }

    // eprintln!("{}", "-".repeat(80));
    // eprintln!("{:?}", dp);
    dp[values.len()][(abs_max as i32 + to) as usize]
}

fn yes_no(is_yes: bool) -> String {
    if is_yes {
        "Yes".to_string()
    } else {
        "No".to_string()
    }
}

fn split_odd_even(a: &Vec<i32>) -> (Vec<i32>, Vec<i32>) {
    let (mut odd, mut even) = (Vec::new(), Vec::new());

    for (index, value) in a.iter().enumerate() {
        if index % 2 == 0 {
            even.push(*value);
        } else {
            odd.push(*value);
        }
    }

    (odd, even)
}

fn read_three<A: str::FromStr, B: str::FromStr, C: str::FromStr>(
    lines: &mut io::Lines<io::StdinLock>,
) -> (A, B, C)
where
    A::Err: Debug + 'static,
    B::Err: Debug + 'static,
    C::Err: Debug + 'static,
{
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: A = parts.next().unwrap().parse().unwrap();
    let b: B = parts.next().unwrap().parse().unwrap();
    let c: C = parts.next().unwrap().parse().unwrap();
    (a, b, c)
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
