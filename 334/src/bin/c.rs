use std::cmp::Reverse;
use std::collections::{BinaryHeap, HashMap, HashSet};
use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, _): (usize, usize) = {
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

    let mut used: HashSet<usize> = HashSet::new();

    for i in 0..a.len() {
        used.insert(a[i] + n);
    }

    // eprintln!("{:?}", used);

    let mut total: usize = 0;

    while true {
        let mut queue: BinaryHeap<(Reverse<usize>, usize, usize)> = BinaryHeap::new();

        let mut values: Vec<usize> = Vec::new();

        for i in 1..=(2 * n) {
            if used.contains(&i) {
                continue;
            }

            values.push(if i > n { i - n } else { i });
        }

        values.sort();

        if values.len() < 2 {
            break;
        }

        for i in 0..(values.len() - 1) {
            queue.push((Reverse(values[i + 1] - values[i]), values[i], values[i + 1]));
        }

        while let Some((Reverse(distance), u, v)) = queue.pop() {
            if (used.contains(&(u + n)) && used.contains(&u))
                || (used.contains(&(v + n)) && used.contains(&v))
            {
                continue;
            }

            if used.contains(&(u + n)) {
                used.insert(u);
            } else {
                used.insert(u + n);
            }
            if used.contains(&(v + n)) {
                used.insert(v);
            } else {
                used.insert(v + n);
            }

            total += distance;
        }
    }

    println!("{}", total);
}
