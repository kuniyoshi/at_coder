use std::io::{self, BufRead};
use std::io::Write;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    println!("{}", n - 1);
    for i in 0..(n -1) {
        println!("1 {}", i + 1);
    }
    std::io::stdout().flush().unwrap();
    let crash: String = lines.next().unwrap().unwrap();
    let pos = crash.chars().position(|c| c == '1');
    match pos {
        None => println!("{}", n),
        Some(p) => println!("{}", p + 1),
    }
    std::io::stdout().flush().unwrap();
    // 3
    // 1 1
    // 1 2
    // 1 3
    // 10
    // 100
}