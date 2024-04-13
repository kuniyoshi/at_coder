use std::io::{self, BufRead};

#[derive(Debug)]
struct R {
    h: usize,
    w: usize,
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, h, w): (usize, usize, usize) = {
        let list: Vec<usize> = lines
            .next()
            .unwrap()
            .unwrap()
            .split_whitespace()
            .map(|s| s.parse().unwrap())
            .collect();
        (list[0], list[1], list[2])
    };
    let rectangles: Vec<R> = (0..n)
        .map(|_| {
            let list: Vec<usize> = lines
                .next()
                .unwrap()
                .unwrap()
                .split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect();
            R {
                h: list[0],
                w: list[1],
            }
        })
        .collect();

    let mut used = vec![false; n];
    let mut map = vec![vec![false; w]; h];

    if test(&mut used, false, &rectangles, &mut map, R { h, w }) {
        println!("Yes");
    } else {
        println!("No");
    }
}

fn cursor(map: &Vec<Vec<bool>>, size: R) -> Option<R> {
    for i in 0..size.h {
        for j in 0..size.w {
            if !map[i][j] {
                return Some(R { h: i, w: j });
            }
        }
    }
    None
}

fn test(used: &mut Vec<bool>, is_angle_horizontal: bool, rectangles: &Vec<R>, map: &mut Vec<Vec<bool>>, size: R) -> bool {
    match cursor(map, size) {
        None => true,
        Some(c) => {
            for i in 0..used.len() {
                if !used[i] {
                    for i in 0..
                }
            }
            false
        }
    }
}
