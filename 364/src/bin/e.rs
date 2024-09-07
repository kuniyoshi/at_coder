fn main() {
    proconio::input! {
        n: usize,
        x: u64,
        y: u64,
        dishes: [(u64, u64); n],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (n, x, y, &dishes));

    let limit = (x + dishes.iter().map(|(a, _)| a).max().unwrap_or(&0)) as usize;

    let mut dp = vec![vec![None; n + 1]; limit + 1];
    dp[0][0] = Some(0);

    for &(sweetness, saltiness) in &dishes {
        let mut next = dp.clone();

        for i in 0..=(x as usize) {
            for j in 0..n {
                match dp[i][j] {
                    Some(min_saltiness) if min_saltiness <= y => {
                        next[i + sweetness as usize][j + 1] = min(
                            next[i + sweetness as usize][j + 1],
                            min_saltiness + saltiness,
                        );
                    }
                    _ => (),
                }
            }
        }

       dp = next;
    }

    // #[cfg(debug_assertions)]
    // eprintln!("{:?}", dp[n]);

    // for i in 0..dp[n].len() {
    //     for j in 0..dp[n][i].len() {
    //         if let Some(saltiness) = dp[n][i][j] {
    //             #[cfg(debug_assertions)]
    //             eprintln!("{:?}", (i, saltiness, j));
    //         }
    //     }
    // }

    let mut max = 0;

    for i in 0..dp.len() {
        for j in 0..dp[i].len() {
            if dp[i][j].is_some() {
                max = max.max(j);
            }
        }
    }

    println!("{}", max);
}

fn min(a: Option<u64>, b: u64) -> Option<u64> {
    if let Some(a_value) = a {
        return Some(a_value.min(b));
    }
    Some(b)
}
