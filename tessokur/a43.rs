use std::io::{self, BufRead};
use std::str::FromStr;
use std::cmp;

fn main() {
    let (n, l): (usize, usize) = read_two();
    let people: Vec<(usize, char)> = read_tuples(n);

    let mut max: usize = 0;

    for &(p, direction) in people.iter() {
        if direction == 'E' {
            max = cmp::max(max, l - p);
        }
        else {
            max = cmp::max(max, p);
        }
    }

    println!("{}", max);
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

fn read_tuples(n: usize) -> Vec<(usize, char)> {
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();
    let mut result = Vec::new();

    for i in 0..n {
        let line = lines.next().unwrap().unwrap();
        let parts: Vec<&str> = line.split_whitespace().collect();

        if parts.len() != 2 {
            eprintln!("Error: Line {} does not contain exactly two elements.", i + 1);
            std::process::exit(1);
        }

        result.push((parts[0].parse().unwrap(), parts[1].parse().unwrap()));
    }

    result
}