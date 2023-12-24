use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    let mut max: usize = 0;

    for i in 0..n {
        for j in 0..i {
            max = max.max(a[i] + a[j]);
        }
    }

    println!("{}", max);
}