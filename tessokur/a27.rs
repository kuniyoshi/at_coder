use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (a, b): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };

    println!("{}", gcd(a, b));
}

fn gcd(a: usize, b: usize) -> usize {
    if a == 0 {
        return b;
    }
    if b == 0 {
        return a;
    }
    if a > b {
        return gcd(b, a % b);
    } else {
        return gcd(a, b % a);
    }
}