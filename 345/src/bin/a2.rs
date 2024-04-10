use regex::Regex;
use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let line = lines.next().unwrap().unwrap();
    let regex = Regex::new(r"^[<][=]*[>]$").unwrap();

    if regex.is_match(&line) {
        println!("Yes");
    } else {
        println!("No");
    }
}
