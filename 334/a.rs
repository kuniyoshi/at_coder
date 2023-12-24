use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (b, g): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };

    println!("{}", if b > g { "Bat" } else { "Glove" });
}