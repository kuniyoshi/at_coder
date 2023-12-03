use std::collections::HashSet;
use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, t): (usize, usize) = {
        let parts: Vec<usize> = lines
            .next()
            .unwrap()
            .unwrap()
            .split_whitespace()
            .map(|s| s.parse().unwrap())
            .collect();
        (parts[0], parts[1])
    };

    let mut links: Vec<Vec<usize>> = vec![Vec::new(); n];

    for _ in 0..(n - 1) {
        let (u, v): (usize, usize) = {
            let parts: Vec<usize> = lines
                .next()
                .unwrap()
                .unwrap()
                .split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect();
            (parts[0] - 1, parts[1] - 1)
        };

        links[u].push(v);
        links[v].push(u);
    }

    let mut ranks: Vec<usize> = vec![0; n];
    let mut visited: HashSet<usize> = HashSet::new();

    traverse(&mut ranks, &links, &mut visited, t - 1);

    for rank in &ranks {
        print!("{} ", rank);
    }

    println!("");
}

fn traverse(
    ranks: &mut Vec<usize>,
    links: &Vec<Vec<usize>>,
    visited: &mut HashSet<usize>,
    who: usize,
) -> usize {
    let mut max: usize = 0;

    visited.insert(who);

    for u in &links[who] {
        if visited.contains(u) {
            continue;
        }

        max = max.max(traverse(ranks, links, visited, *u) + 1);
    }

    ranks[who] = max;

    max
}
