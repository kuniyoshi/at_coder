use std::io::{self, BufRead};
use std::collections::HashMap;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let classes: Vec<(usize, usize)> = (0..n)
        .map(|_| {
            let a: Vec<usize> = lines
                .next()
                .unwrap()
                .unwrap()
                .split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect();
            (a[0], a[1])
        })
        .collect();

    let mut class_of: HashMap<usize, usize> = HashMap::new();

    for &(u, class) in &classes {
        class_of.insert(u, class);
    }

    let mut neighbors: Vec<Vec<usize>> = vec![Vec::new(); 10_000];

    for &(u, class) in &classes {
        for i in 0..4 {
            for j in 0..=9 {

            }
        }
    }
}
