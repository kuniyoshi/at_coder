use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let mut s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();

    for c in ['A', 'B', 'C'] {
        while s.len() > 0 && s[0] == c {
            s.remove(0);
        }
    }

    println!("{}", if s.len() == 0 { "Yes" } else { "No" });
}