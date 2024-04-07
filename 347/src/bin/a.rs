use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (_, k): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    let mut results: Vec<_> = a.iter().filter(|v| *v % k == 0).map(|v| v / k).collect();
    results.sort();

    for result in &results {
        print!("{} ", result);
    }

    println!();
}
