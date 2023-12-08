use std::collections::HashMap;
use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let mut a: Vec<usize> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();

    let mut indexes: HashMap<usize, Vec<usize>> = HashMap::new();

    for i in 0..n {
        let entry = indexes.entry(a[i]).or_insert(Vec::new());
        entry.push(i);
    }

    a.sort_by(|a, b| b.cmp(&a));
    a.dedup();

    let mut results: Vec<usize> = vec![0; n];
    let mut acc: usize = 0;

    for value in &a {
        let entry = indexes.entry(*value).or_insert(Vec::new());
        for i in 0..entry.len() {
            results[entry[i]] = acc;
        }
        acc += value * entry.len();
    }

    for i in 0..n {
        print!("{} ", results[i]);
    }

    println!("");
}
