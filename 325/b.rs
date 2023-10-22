use std::io::{self, BufRead};
use std::cmp::max;

fn main() {
    let offices = read_offices();
    let mut max_total = 0;

    for i in 0..24 {
        let mut total = 0;

        for &office in &offices {
            total += t(i, office);
        }

        max_total = max(max_total, total);
    }

    println!("{}", max_total);
}

fn read_offices() -> Vec<(i32, i32)> {
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();

    let n: usize = lines.next().unwrap().unwrap().trim().parse().unwrap();
    let mut offices: Vec<(i32, i32)> = Vec::new();

    for _ in 0..n {
        let line = lines.next().unwrap().unwrap();
        let parts: Vec<i32> = line.split_whitespace().map(|s| s.parse().unwrap()).collect();
        offices.push((parts[0], parts[1]));
    }

    offices
}

fn t(h: i32, office: (i32, i32)) -> i32 {
    let (w, x) = office;
    let area_hour = (x + h) % 24;
    if area_hour >= 9 && area_hour <= 17 {
        return w;
    }
    0
}
