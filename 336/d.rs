use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    let mut maxes = a.clone();

    for i in 0..n {
        maxes[i] = (i + 1).min(maxes[i]).min(if i > 0 { maxes[i - 1] + 1 } else { 1 });
    }

    maxes.reverse();

    for i in 0..n {
        maxes[i] = (i + 1).min(maxes[i]).min(if i > 0 { maxes[i - 1] + 1 } else { 1 });
    }

    maxes.reverse();

    println!("{}", maxes.iter().max().unwrap());
}
