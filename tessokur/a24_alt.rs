use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let _: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    let mut dp: Vec<Option<usize>> = vec![None;   a.iter().max().map_or(0, |v| *v) + 1];
    let mut mins: Vec<Option<usize>> = vec![None; a.iter().max().map_or(0, |v| *v) + 1];

    for value in &a {
        dp[*value] = dp[*value].map_or(Some(1), |v| Some(v));

        let mut ac: usize = 0;
        let mut wa: usize = *value;

        while wa - ac > 1 {
            let wj = (ac + wa) / 2;
            match mins[wj] {
                Some(mins_value) if mins_value < *value => ac = wj,
                _ => wa = wj,
            };
        }

        dp[*value] = Some((ac + 1).max(dp[*value].unwrap()));
        mins[dp[*value].unwrap()] = Some(*value);
    }

    let mut max: usize = 0;

    for v in &dp {
        match v {
            Some(value) => max = max.max(*value),
            _ => (),
        };
    }

    println!("{}", max);
}