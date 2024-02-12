use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();

    let dot: Option<usize> = s.iter().rposition(|&c| c == '.');

    match dot {
        None => println!("{}", s.iter().collect::<String>()),
        Some(p) => println!("{}", s[(p+1)..s.len()].iter().collect::<String>()),
    };
}