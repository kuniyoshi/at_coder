use std::io::{self, BufRead};

fn main() {
    let stdin = io::stdin();
    let _ = stdin.lock().lines().next().unwrap().unwrap();
    let line = stdin.lock().lines().next().unwrap().unwrap();
    if line.chars().collect::<Vec<char>>().windows(3).any(|w| w[0] == w[1] && w[1] == w[2]) {
        println!("Yes");
    } else {
        println!("No");
    }
}