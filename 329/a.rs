use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();
    println!("{}", s.iter().map(|c| c.to_string()).collect::<Vec<_>>().join(" "));
}