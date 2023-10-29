use std::io::{self, BufRead};

fn main() {
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let mut a: Vec<usize> = Vec::new();

    for _ in 0..n {
        a.push(lines.next().unwrap().unwrap().parse().unwrap());
    }

    let mut count: std::collections::HashMap<usize, usize> = std::collections::HashMap::new();

    for &v in &a {
        *count.entry(v).or_insert(0) += 1;
    }

    let mut result = 0usize;

    for (_, value) in &count {
        result += (value - 1) * value / 2;
    }

    println!("{}", result);
}