use std::io::{self, BufRead};
use std::str::FromStr;

fn main() {
    let (n, m): (usize, usize) = read_two();
    let a = read_values();
    let mut fails: Vec<usize> = vec!(0; n);

    for &fail in a.iter() {
        fails[fail - 1] += 1;
    }

    for i in 0..n {
        println!("{}", m - fails[i]);
    }
}

fn read_two<T: FromStr, U: FromStr>() -> (T, U)
where
    T::Err: std::fmt::Debug,
    U::Err: std::fmt::Debug,
{
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a = parts.next().unwrap().parse().expect("Failed to parse");
    let b = parts.next().unwrap().parse().expect("Failed to parse");
    (a, b)
}

fn read_values() -> Vec<usize> {
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();
    let line = lines.next().unwrap().unwrap();
    line.split_whitespace().map(|x| x.parse().unwrap()).collect()
}