use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let conditions: Vec<(usize, usize)> = (0..n).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    }).collect();

    // 左から x 個、右から y 個のとき、最大のスコア
    let mut dp: Vec<Vec<usize>> = vec![vec![0; n + 2]; n + 1];

    for i in 1..=n {
        for j in (1..=n).rev() {
            if j < i {
                continue;
            }

            let a = score_l(&conditions, i - 1, j);
            let b = score_r(&conditions, i, j + 1);

            dp[i][j] = (dp[i - 1][j] + a).max(dp[i][j + 1] + b);
        }
    }

    let mut max: usize = 0;

    for i in 0..=n {
        for j in 0..=n {
            max = max.max(dp[i][j]);
        }
    }

    println!("{}", max);
}

fn score_l(conditions: &Vec<(usize, usize)>, left: usize, right: usize) -> usize {
    if left < 1 {
        return 0;
    }

    score_(conditions[left - 1], left, right)
}

fn score_r(conditions: &Vec<(usize, usize)>, left: usize, right: usize) -> usize {
    if right > conditions.len() {
        return 0;
    }

    score_(conditions[right - 1], left, right)
}

fn score_((condition, score): (usize, usize), left: usize, right: usize) -> usize {
    if left <= condition && right >= condition {
        score
    }
    else {
        0
    }
}
