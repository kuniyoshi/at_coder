use std::collections::BinaryHeap;
use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, k): (usize, usize) = {
        let list: Vec<usize> = lines
            .next()
            .unwrap()
            .unwrap()
            .split_whitespace()
            .map(|s| s.parse().unwrap())
            .collect();
        (list[0], list[1])
    };
    let a: Vec<usize> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();

    let mut heap: BinaryHeap<(usize, usize)> = BinaryHeap::new();

    for i in 0..n {
        for j in 1..=k {
            heap.push((a[i] * 1_000_000_000 / j, i));
        }
    }

    let mut seats: Vec<usize> = vec![0; n];
    let mut got: usize = 0;

    while heap.len() > 0 {
        match heap.pop() {
            Some((_, tou)) => {
                seats[tou] += 1;
            }
            _ => panic!("unknown"),
        }

        got += 1;

        if got == k {
            break;
        }
    }

    for i in 0..n {
        print!("{} ", seats[i]);
    }
}
