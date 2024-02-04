use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();

    let mut is = s[0].is_uppercase();

    for i in 1..s.len() {
        is &= s[i].is_lowercase();
    }

    println!("{}", if is { "Yes" } else { "No" });
}