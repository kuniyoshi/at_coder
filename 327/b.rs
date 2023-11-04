use fmt::Debug;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let b: usize = read_one(&mut lines);
    match test(b) {
        Some(a) => println!("{}", a),
        None => println!("{}", -1),
    }
}

fn power(a: usize, b: usize) -> usize {
    let mut result = 1usize;

    for _ in 0..b {
        result *= a;
    }

    result
}

fn test(b: usize) -> Option<usize> {
    for i in 1..=15 {
        if power(i, i) == b {
            return Some(i);
        }
    }

    None
}

fn read_one<A: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> A
where
    A::Err: Debug + 'static,
{
    lines.next().unwrap().unwrap().parse().unwrap()
}
