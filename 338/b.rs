use std::io::{self, BufRead};
use std::collections::HashMap;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();

    let mut count: HashMap<char, usize> = HashMap::new();

    for c in &s {
        *count.entry(*c).or_insert(0) += 1;
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", count);

    let max = count.values().max().unwrap();
    let mut keys: Vec<_> = count.keys().collect();
    keys.sort();

    for key in &keys {
        match count.get(key) {
            Some(c) if c == max => {
                println!("{}", key);
                break;
            }
            _ => (),
        }
    }
}