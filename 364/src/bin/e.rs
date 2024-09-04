fn main() {
    proconio::input! {
        n: usize,
        x: u64,
        y: u64,
        dishes: [(u64, u64); n],
    };

    #[cfg(debug_assertions)]
    eprintln!("{:?}", (n, x, y, &dishes));

    let border = 10_010;

    let mut dp = vec![None; border * border];
    dp[0] = Some(0);

    for &(sweetness, saltiness) in &dishes {
        for i in (0..dp.len()).rev() {
            match i.checked_sub((sweetness * border as u64 + saltiness) as usize) {
                None => continue,
                Some(previous) => {
                    match dp[previous] {
                        None => continue,
                        Some(count) => {
                            match dp[i] {
                                None => dp[i] = Some(1),
                                Some(current_count) => dp[i] = Some(current_count.max(count + 1)),
                            }
                        }
                    }
                }
            };
        }
    }

    let mut max = 0;

    for (index, &count) in dp.iter().enumerate() {
        if index > x as usize * border + y as usize {
            continue;
        }

        match count {
            Some(c) => max = max.max(c),
            _ => continue,
        }
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", max);
}
