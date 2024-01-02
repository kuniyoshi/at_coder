use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let mut a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
    let mut b: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    a.insert(0, 0);
    b.insert(0, 0);
    b.insert(0, 0);

    // eprintln!("{:?}", a);
    // eprintln!("{:?}", b);

    //  1  2  3  4  5
    // [0, 2, 4, 1, 3]
    // [0, 0, 5, 3, 7]
    //  0  2  5  5  8

    let mut dp: Vec<usize> = vec![a.iter().sum::<usize>() + b.iter().sum::<usize>(); n + 1];
    dp[0] = 0;
    dp[1] = 0;

    for i in 1..=n {
        if i > 1 {
            dp[i] = dp[i].min(dp[i - 1] + a[i - 1]);
        }
        if i > 2 {
            dp[i] = dp[i].min(dp[i - 2] + b[i - 1]);
        }
    }

    // eprintln!("{:?}", dp);

    println!("{}", dp[n]);
}