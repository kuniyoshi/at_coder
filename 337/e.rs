use std::io::{self, BufRead};
use std::io::Write;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    println!("{}", n);
    for i in 0..n {
        println!("1 {}", i + 1);
    }
    std::io::stdout().flush().unwrap();
    let crash: String = lines.next().unwrap().unwrap();
    let pos = crash.chars().position(|c| c == '1').unwrap();
    println!("{}", pos + 1);
    std::io::stdout().flush().unwrap();
    // 3
    // 1 1
    // 1 2
    // 1 3
}