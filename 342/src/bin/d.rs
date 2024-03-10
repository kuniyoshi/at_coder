use std::io::{self, BufRead};
use std::collections::HashMap;


fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    let mut squares = Vec::new();

    for i in 0..=200_000 {
        if i * i > 200_000 {
            break;
        }
        squares.push(i * i);
    }

    let mut count = HashMap::new();

    for i in 0..n {
        *count.entry(a[i]).or_insert(0) += 1;
    }

    let mut total = 0;

    for (key, value) in count.iter() {
        if key == &0 {
            total += n - 1;
            continue;
        }

        for i in 0..squares.len() {
            if squares[i] % key == 0 && count.contains_key(&(squares[i] / key)) {
                let addition = count[&(squares[i] / key)] - if squares[i] / key == *key { 1 } else { 0 };
                total += value * addition;
            }
        }
    }

    println!("{}", total / 2);
}
