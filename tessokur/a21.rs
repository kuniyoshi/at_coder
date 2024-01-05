use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let conditions: Vec<(usize, usize)> = (0..n).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    }).collect();

    eprintln!("{:?}", conditions);

    // 左から x 個、右から y 個のとき、最大のスコア
    let mut dp: Vec<Vec<usize>> = vec![vec![0; n + 1]; n + 1];

    // [1: (3, 20), 2: (2, 30), 3: (1, 40), 4: (0, 10)]
    // [     0   1   2   3  4
    //   0: [0,  0,  0,  0, 0],
    //   1: [0,  0, 30, 70, 0],
    //   2: [0, 30, 60,  0, 0],
    //   3: [0, 70,  0,  0, 0],
    //   4: [0,  0,  0,  0, 0]
    // ]

    for i in 0..n {
        for j in 0..n {
            if i + j - 2 >= n {
                continue;
            }

            let a = dp[i - 1][j] + if conditions[i - 1].0 < i + j { conditions[i - 1].1 } else { 0 };
            let b = dp[i][j - 1] + if conditions[j - 1].0 < i + j { conditions[j - 1].1 } else { 0 };
            dp[i][j] = dp[i][j].max(a.max(b));
        }
    }

    eprintln!("{:?}", dp);

    let mut max: usize = 0;

    for i in 0..=n {
        for j in 0..=n {
            max = max.max(dp[i][j]);
        }
    }

    println!("{}", max);
}