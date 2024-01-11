use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let q: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let x: Vec<usize> = (0..q).map(|_| {
        lines.next().unwrap().unwrap().parse().unwrap()
    }).collect();

    let mut primes: Vec<bool> = vec![true; x.iter().max().unwrap() + 1];
    primes[0] = false;
    primes[1] = false;

    for i in 2..primes.len() {
        if !primes[i] {
            continue;
        }

        for j in ((2 * i)..primes.len()).step_by(i) {
            primes[j] = false;
        }
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", primes);

    for query in &x {
        println!("{}", if primes[*query] { "Yes" } else { "No" });
    }
}