use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let mut a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
    let mut b: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    a.insert(0, 0);
    b.insert(0, 0);
    b.insert(0, 0);

    let mut dp: Vec<usize> = vec![a.iter().sum::<usize>() + b.iter().sum::<usize>(); n + 1];
    dp[0] = 0;
    dp[1] = 0;

    for i in 2..=n {
        dp[i] = dp[i].min(dp[i - 1] + a[i - 1]);
        if i > 2 {
            dp[i] = dp[i].min(dp[i - 2] + b[i - 1]);
        }
    }

    // eprintln!("{:?}", dp);

    let mut cursor: usize = n;
    let mut paths: Vec<usize> = Vec::new();

    while cursor != 1 {
        if dp[cursor - 1] == dp[cursor] - a[cursor - 1] {
            paths.push(cursor);
            cursor -= 1;
            continue;
        }

        if cursor > 2 && dp[cursor - 2] == dp[cursor] - b[cursor - 1] {
            paths.push(cursor);
            cursor -= 2;
            continue;
        }
    }

    paths.push(1);
    paths.reverse();

    println!("{}", paths.len());

    for i in 0..paths.len() {
        print!("{} ", paths[i]);
    }

    println!("");
}