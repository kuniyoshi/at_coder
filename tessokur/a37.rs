use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, m, b): (usize, usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1], list[2])
    };
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
    let c: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    let mut total: usize = 0;

    for station in &a {
        total += station * m;
    }

    for buss in &c {
        total += buss * n;
    }

    // 111+112+113+121+122+123
    // 11 + 12 + 13 + 21 + 22 + 23 + 100 * 2 + 100 * 3
    total += b * n * m;

    println!("{}", total);
}