use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let s: String = lines.next().unwrap().unwrap();
    let mut t: Vec<_> = s.chars().collect();
    t.sort();

    println!("{}", if s == t.iter().collect::<String>() { "Yes" } else { "No" });
}