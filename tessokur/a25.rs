use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (h, w): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };
    let cells: Vec<Vec<char>> = (0..h).map(|_| lines.next().unwrap().unwrap().chars().collect()).collect();

    let mut dp: Vec<Vec<usize>> = vec![vec![0; w]; h];

    for i in 0..h {
        for j in 0..w {
            dp[i][j] = 
        }
    }
}