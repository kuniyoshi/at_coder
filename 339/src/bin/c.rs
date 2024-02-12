use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let _: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let a: Vec<i64> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    let mut acc: Vec<i64> = vec![0];

    for v in &a {
        acc.push(acc.last().unwrap() + v);
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", acc);

    let min = acc.iter().min().unwrap();

    if min >= &0 {
        println!("{}", acc.last().unwrap());
    } else {
        println!("{}", acc.last().unwrap() + min.abs());
    }
}