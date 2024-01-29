use std::io::{self, BufRead};
use regex::Regex;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let s = lines.next().unwrap().unwrap();
    let re = Regex::new("^A*B*C*$").unwrap();

    println!("{}", if re.is_match(s) { "Yes" } else { "No" });
}