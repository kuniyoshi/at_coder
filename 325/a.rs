use std::io::{self, BufRead};

fn main() {
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();

    let input = lines.next().unwrap().unwrap();
    let words: Vec<&str> = input.split_whitespace().collect();
    let (s, _t) = (words[0], words[1]);

    println!("{} san", s);
}
