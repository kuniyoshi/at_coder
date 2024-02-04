use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let edges: Vec<(usize, usize, usize)> = (0..n).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        let distance_a = list[1].max(list[0]) - list[1].min(list[0]);
        let distance_b = 
        (list[0], list[1], list[2])
    }).collect();
}