use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, q): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
    let spans: Vec<(usize, usize)> = (0..q).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    }).collect();

    let mut totals: Vec<usize> = vec![0];

    for i in 0..n {
        totals.push(totals.last().unwrap() + a[i]);
    }

    for &(l, r) in &spans {
        println!("{}", totals[r] - totals[l-1]);
    }
}