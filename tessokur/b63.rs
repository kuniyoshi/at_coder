use std::collections::VecDeque;
use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let rc: Vec<usize> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();
    let (row_size, col_size) = (rc[0], rc[1]);
    let start: Vec<usize> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .map(|v: usize| v - 1)
        .collect();
    let goal: Vec<usize> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .map(|v: usize| v - 1)
        .collect();
    let cells: Vec<Vec<char>> = (0..row_size)
        .map(|_| lines.next().unwrap().unwrap().chars().collect())
        .collect();

    let mut costs: Vec<Vec<usize>> = vec![vec![usize::MAX; col_size]; row_size];
    costs[start[0]][start[1]] = 0;
    let mut queue: VecDeque<(usize, usize)> = VecDeque::new();
    queue.push_back((start[0], start[1]));

    let deltas: Vec<(i64, i64)> = vec![(-1, 0), (0, 1), (1, 0), (0, -1)];

    while let Some((i, j)) = queue.pop_front() {
        for (di, dj) in &deltas {
            let (ni, nj): (i64, i64) = (i as i64 + di, j as i64 + dj);
            if is_in_range(ni, row_size)
                && is_in_range(nj, col_size)
                && cells[ni as usize][nj as usize] == '.'
            {
                if costs[ni as usize][nj as usize] <= costs[i][j] + 1 {
                    continue;
                } else {
                    costs[ni as usize][nj as usize] = costs[i][j] + 1;
                    queue.push_back((ni as usize, nj as usize));
                }
            }
        }
    }

    println!("{}", costs[goal[0]][goal[1]]);
}

fn is_in_range(value: i64, max: usize) -> bool {
    value >= 0 && (value as usize) < max
}
