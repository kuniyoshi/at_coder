use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (a, b, d): (usize, usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1], list[2])
    };

    let mut c = a;

    while c <= b {
        print!("{} ", c);
        c += d;
    }

    println!("");
}
