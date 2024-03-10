use std::io::{self, BufRead};
use std::collections::HashMap;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();
    let mut count = HashMap::new();
    for c in &s {
        *count.entry(c).or_insert(0) += 1;
    }
    let c = count.iter().find(|(_, &value)| value == 1).map(|(key, _)| key).unwrap();
    println!("{}", s.iter().position(|sc| sc == *c).unwrap() + 1);
}
