use std::io::{self, BufRead};
use std::collections::VecDeque;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (h, w, k): (usize, usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1], list[2])
    };
    let mut cells: Vec<Vec<char>> = (0..h).map(|_| lines.next().unwrap().unwrap().chars().collect()).collect();
    // #[cfg(debug_assertions)]
    // eprintln!("{:?}", cells);

    let mut min: usize = 2 * h * w;

    for i in 0..h {
        let mut counts: Vec<usize> = vec![0; k];
        let mut chars: VecDeque<char> = cells[i][0..(k.min(w))].iter().map(|c| *c).collect();

        for &c in &chars {
            match c {
                'o' => counts[0] += 1,
                'x' => counts[1] += 1,
                '.' => counts[2] += 1,
                _ => panic!("unknown"),
            }
        }

        if counts[1] == 0 {
            min = min.min(counts[2]);
        }

        for j in k..(if w >= k { w - k } else { 0 }) {
            match chars[0] {
                'o' => counts[0] -= 1,
                'x' => counts[1] -= 1,
                '.' => counts[2] -= 1,
                _ => panic!("unknown"),
            };
            chars.pop_front();
            chars.push_back(cells[i][j]);
            match chars[chars.len() - 1] {
                'o' => counts[0] -= 1,
                'x' => counts[1] -= 1,
                '.' => counts[2] -= 1,
                _ => panic!("unknown"),
            };

            if counts[1] == 0 {
                min = min.min(counts[2]);
            }
        }
    }

    let mut w_cells: Vec<Vec<char>> = vec![vec![' '; h]; w];
    for i in 0..h {
        for j in 0..w {
            w_cells[j][i] = cells[i][j];
        }
    }

    for i in 0..w {
        let mut counts: Vec<usize> = vec![0; k];
        let mut chars: VecDeque<char> = w_cells[i][0..(k.min(h))].iter().map(|c| *c).collect();

        for &c in &chars {
            match c {
                'o' => counts[0] += 1,
                'x' => counts[1] += 1,
                '.' => counts[2] += 1,
                _ => panic!("unknown"),
            }
        }

        if counts[1] == 0 {
            min = min.min(counts[2]);
        }

        for j in k..(if h >= k { h - k } else { 0 }) {
            match chars[0] {
                'o' => counts[0] -= 1,
                'x' => counts[1] -= 1,
                '.' => counts[2] -= 1,
                _ => panic!("unknown"),
            };
            chars.pop_front();
            chars.push_back(w_cells[i][j]);
            match chars[chars.len() - 1] {
                'o' => counts[0] -= 1,
                'x' => counts[1] -= 1,
                '.' => counts[2] -= 1,
                _ => panic!("unknown"),
            };

            if counts[1] == 0 {
                min = min.min(counts[2]);
            }
        }
    }

    if min == 2 * h * w {
        println!("{}", -1);
    }
    else {
        println!("{}", min);
    }
}