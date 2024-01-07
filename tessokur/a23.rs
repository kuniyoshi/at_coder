use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, m): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };
    let coupons: Vec<usize> = (0..m).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        let mut value: usize = 0;

        for i in 0..list.len() {
            if list[i] == 1 {
                value |= 1 << i;
            }
        }

        value
    }).collect();

    #[cfg(debug_assertions)]
    eprintln!("{:?}", coupons);

    let mut dp: Vec<Vec<Option<usize>>> = vec![vec![None; pow2(n)]; m + 1];
    dp[0][0] = Some(0);

    for i in 0..m {
        for j in (0..pow2(n)).rev() {
            dp[i + 1][j] = min(dp[i + 1][j], dp[i][j], 0);
            dp[i + 1][j | coupons[i]] = min(dp[i + 1][j | coupons[i]], dp[i][j], 1);
        }
    }

    match dp[m][pow2(n) - 1] {
        Some(count) => println!("{}", count),
        _ => println!("{}", -1),
    }
}

fn min(current: Option<usize>, candidate: Option<usize>, addition: usize) -> Option<usize> {
    match (current, candidate) {
        (Some(count), Some(other)) => Some(count.min(other + addition)),
        (Some(_), None) => current,
        (None, Some(other)) => Some(other + addition),
        _ => None,
    }
}

fn pow2(kata: usize) -> usize {
    2usize.pow(kata as u32)
}
