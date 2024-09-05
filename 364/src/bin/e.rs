fn main() {
    proconio::input! {
        n: usize,
        x: u64,
        y: u64,
        dishes: [(u64, u64); n],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (n, x, y, &dishes));

    let limit = (dishes.iter().map(|(a, _)| *a).max().unwrap_or(0) + x.max(y) + 1) as usize;

    let mut dp = vec![vec![vec![None; limit]; limit]; n + 1];
    dp[0][0][0] = Some(0);

    for (index, &(sweetness, saltiness)) in dishes.iter().enumerate() {
        for i in 0..limit {
            if i > x as usize {
                continue;
            }

            for j in 0..limit {
                if j > y as usize {
                    continue;
                }

                if let Some(count) = dp[index][i as usize][j as usize] {
                    dp[index + 1][i + sweetness as usize][j + saltiness as usize] = max(
                        dp[index][i + sweetness as usize][j + saltiness as usize],
                        count + 1,
                    );
                }
            }
        }
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", dp);

    let mut result = 0;

    for i in 0..limit {
        for j in 0..limit {
            if let Some(count) = dp[dishes.len()][i][j] {
                result = result.max(count);
            }
        }
    }

    println!("{}", result);
}

fn max(a: Option<u64>, b: u64) -> Option<u64> {
    if let Some(a_value) = a {
        return Some(a_value.max(b));
    }
    None
}
