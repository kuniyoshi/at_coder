use std::io::{self, BufRead};
use std::cmp::Ordering;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let xy: Vec<(usize, usize)> = (0..n).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    }).collect();

    let t: usize = xy.iter().map(|t| t.0).sum();
    let a: usize = xy.iter().map(|t| t.1).sum();
    println!("{}", match t.cmp(&a) {
        Ordering::Equal => "Draw",
        Ordering::Greater => "Takahashi",
        Ordering::Less => "Aoki",
    });
}