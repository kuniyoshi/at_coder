use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let _: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    let mut counts: Vec<usize> = vec![0; a.iter().max().unwrap() + 1];

    for value in &a {
        counts[*value] += 1;
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", counts);

    let mut total: usize = 0;

    for count in &counts {
        total += c(*count, 3);
    }

    println!("{}", total);
}

fn c(a: usize, b: usize) -> usize {
    if a < b {
        return 0;
    }

    f(a, b) / f(b, b)
}

fn f(a: usize, b: usize) -> usize {
    let mut result = 1;

    for i in 0..b {
        result *= a - i;
    }

    result
}