use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, w): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };
    let items: Vec<(usize, usize)> = (0..n).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    }).collect();

    let mut dp: Vec<Option<usize>> = vec![None; w + 1];
    dp[0] = Some(0);

    for i in 0..n {
        for j in (items[i].0..=w).rev() {
            match dp[j - items[i].0] {
                Some(value) => dp[j] = select_value(value + items[i].1, dp[j]),
                None => (),
            }
        }
    }

    let mut max: usize = 0;
    
    for optional in &dp {
        match optional {
            Some(value) => max = max.max(*value),
            None => (),
        }
    }

    println!("{}", max);
}

fn select_value(new_value: usize, other: Option<usize>) -> Option<usize> {
    match other {
        None => Some(new_value),
        Some(other_value) => Some(other_value.max(new_value)),
    }
}