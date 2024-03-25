use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (a, b): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };

    if a + b == 0 {
        println!("1");
    } else {
        println!("0");
    }
}
