use std::io::{self, BufRead};
use std::collections::VecDeque;

fn main() {
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let h: usize = parts.next().unwrap().parse().unwrap();
    let w: usize = parts.next().unwrap().parse().unwrap();

    let mut s: Vec<Vec<char>> = Vec::new();

    for _ in 0..h {
        let row: Vec<char> = lines.next().unwrap().unwrap().chars().collect();
        s.push(row);
    }

    let mut visited = vec![vec![false; w]; h];

    let mut count = 0;

    for i in 0..h {
        for j in 0..w {
            if visited[i][j] {
                continue;
            }
            if s[i][j] != '#' {
                continue;
            }

            count += 1;

            let mut queue = VecDeque::new();
            queue.push_back([i, j]);

            while let Some([r, c]) = queue.pop_front() {
                if visited[r][c] {
                    continue;
                }

                visited[r][c] = true;

                for k in -1..=1 {
                    for l in -1..=1 {
                        if k == 0 && l == 0 {
                            continue;
                        }

                        let row = r as isize + k;
                        let col = c as isize + l;

                        if row < 0 || row >= h as isize || col < 0 || col >= w as isize {
                            continue;
                        }

                        if s[row as usize][col as usize] != '#' {
                            continue;
                        }

                        if visited[row as usize][col as usize] {
                            continue;
                        }

                        queue.push([row as usize, col as usize]);
                    }
                }
            }
        }
    }

    println!("{}", count);
}
