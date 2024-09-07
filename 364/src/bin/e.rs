fn main() {
    proconio::input! {
        n: usize,
        x: u64,
        y: u64,
        dishes: [(u64, u64); n],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (n, x, y, &dishes));

    let mut dp = vec![vec![None; n + 1]; (x + 1) as usize];
    dp[0][0] = Some(0);

    for &(sweetness, saltiness) in &dishes {
        for i in (0..=(x as usize)).rev() {
            if i as u64 + sweetness > x {
                continue;
            }

            for j in 0..n {
                if let Some(min_saltiness) = dp[i][j] {
                    if min_saltiness + saltiness <= y {
                        dp[i + sweetness as usize][j + 1] =
                            min(dp[i + sweetness as usize][j + 1], min_saltiness + saltiness);
                    }
                }
            }
        }
    }

    let max = dp
        .iter()
        .flat_map(|row| row.iter().enumerate().filter_map(|(j, &v)| v.map(|_| j)))
        .max()
        .unwrap_or(0);

    println!("{}", (max + 1).min(n));
}

fn min(a: Option<u64>, b: u64) -> Option<u64> {
    if let Some(a_value) = a {
        return Some(a_value.min(b));
    }
    Some(b)
}
