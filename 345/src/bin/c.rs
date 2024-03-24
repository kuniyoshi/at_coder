use std::io::{self, BufRead}; // TODO: テンプレートに入れよう
use std::collections::HashMap;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();

    let mut count = HashMap::new();

    for c in &s {
        *count.entry(c).or_insert(0) += 1;
    }

    let mut total = if count.len() < s.len() { 1 } else { 0 };

    for c in &s {
        total += count.len() - 1;
        *count.entry(c).or_insert(0) -= 1;

        if count.entry(c).or_insert(0) == &0 {
            count.remove(c);
        }
    }

    println!("{}", total);
}
