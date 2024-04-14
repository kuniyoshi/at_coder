use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();

    for i in 1..=n {
        print!("{}", if i % 3 == 0 { "x" } else { "o" });
    }

    println!("");
}
