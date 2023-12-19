use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();

    let rep_units = rep_units();
    let mut results: Vec<usize> = Vec::new();

    for i in 0..rep_units.len() {
        for j in 0..rep_units.len() {
            for k in 0..rep_units.len() {
                results.push(rep_units[i] + rep_units[j] + rep_units[k]);
            }
        }
    }

    results.sort();
    results.dedup();

    println!("{}", results[n - 1]);
}

fn rep_units() -> Vec<usize> {
    let mut results = Vec::new();
    let mut acc: usize = 1;
    while acc <= 111_111_111_111 {
        results.push(acc);
        acc = acc * 10 + 1;
    }
    results
}
