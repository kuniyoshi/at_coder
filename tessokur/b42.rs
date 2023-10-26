use std::io::{self, BufRead};
use std::str::FromStr;
use std::cmp;

fn main() {
    let n: usize = read_one();
    let cards: Vec<(i64, i64)> = read_tuples(n);

    println!("{}", cmp::max(cmp::max(calc((1, 1), &cards), calc((-1, -1), &cards)), cmp::max(calc((-1, 1), &cards), calc((1, -1), &cards))));
}

fn calc(multiply: (i64, i64), cards: &Vec<(i64, i64)>) -> i64 {
    let mut max: i64 = 0;

    for &(a, b) in cards.iter() {
        max = cmp::max(
            max,
            max + a * multiply.0 + b * multiply.1
        );
    }

    max
}

fn read_one<T: FromStr>() -> T
where
    T::Err: std::fmt::Debug,
{
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();
    lines.next().unwrap().unwrap().parse().unwrap()
}

fn read_tuples<T: FromStr>(n: usize) -> Vec<(T, T)>
where T::Err: std::fmt::Debug
{
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();
    let mut result = Vec::new();

    for i in 0..n {
        let line = lines.next().unwrap().unwrap();
        let mut parts: Vec<T> = line.split_whitespace().map(|s| s.parse().unwrap()).collect();

        if parts.len() != 2 {
            eprintln!("Error: Line {} does not contain exactly two elements.", i + 1);
            std::process::exit(1);
        }

        let a = parts.pop().unwrap();
        let b = parts.pop().unwrap();

        result.push((a, b));
    }

    result
}