use std::io::{self, BufRead};

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

            recursive([i, j], &mut visited, &s, h, w);
        }
    }

    println!("{}", count);
}

fn recursive([row, col]: [usize; 2], visited: &mut Vec<Vec<bool>>, s: &Vec<Vec<char>>, h: usize, w: usize) {
    if visited[row][col] {
        return;
    }

    visited[row][col] = true;

    for i in -1..=1 {
        for j in -1..=1 {
            if let Some([r, c]) = coord([row, col], [i, j], h, w) {
                if visited[r][c] {
                    continue;
                }

                if s[r][c] != '#' {
                    continue;
                }

                recursive([r, c], visited, &s, h, w);
            }
        }
    }
}

fn coord([row, col]: [usize; 2], [dr, dc]: [isize; 2], h: usize, w: usize) -> Option<[usize; 2]> {
    if let Some(r) = dcoord(row, dr, h) {
        if let Some(c) = dcoord(col, dc, w) {
            return Some([r, c]);
        }
    }

    None
}

fn dcoord(current: usize, delta: isize, max: usize) -> Option<usize> {
    let r = current as isize + delta;
    if r >= 0 && (r as usize) < max {
        return Some(r as usize);
    }

    None
}
