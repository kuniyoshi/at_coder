use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (h, w): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };
    let cells: Vec<Vec<char>> = (0..h).map(|_| lines.next().unwrap().unwrap().chars().collect()).collect();

    let mut dp: Vec<Vec<usize>> = vec![vec![0; w]; h];

    dp[0][0] = 1;

    for i in 0..h {
        for j in 0..w {
            if cells[i][j] == '#' {
                continue;
            }

            if i == 0 && j == 0 {
                dp[i][j] = 1;
                continue;
            }

            dp[i][j] = if i > 0 { dp[i - 1][j] } else { 0 } + if j > 0 { dp[i][j - 1] } else { 0 };
        }
    }

    println!("{}", dp[h - 1][w - 1]);
}