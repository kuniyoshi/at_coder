use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let mut s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();
    let length = s.len();
    s[length - 1] = '4';

    for c in &s {
        print!("{}", c);
    }

    println!("");
}