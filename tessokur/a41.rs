use std::io::{self, BufRead};

fn main() {
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();
    let line = lines.next().unwrap().unwrap();
    let n: usize = line.trim().parse().unwrap();

    let line2 = lines.next().unwrap().unwrap();
    let has_three_consecutive_chars = line2.chars().collect::<Vec<char>>().windows(3).any(|w| w[0] == w[1] && w[1] == w[2]);
    println!("{}", if has_three_consecutive_chars { "Yes" } else { "No" });
}