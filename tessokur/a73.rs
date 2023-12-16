use std::cmp::Reverse;
use std::collections::BinaryHeap;
use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, m): (usize, usize) = {
        let list: Vec<usize> = lines
            .next()
            .unwrap()
            .unwrap()
            .split_whitespace()
            .map(|s| s.parse().unwrap())
            .collect();
        (list[0], list[1])
    };
    let edges: Vec<(usize, usize, usize)> = (0..m)
        .map(|_| {
            let list: Vec<usize> = lines
                .next()
                .unwrap()
                .unwrap()
                .split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect();
            (list[0] - 1, list[1] - 1, list[2] * 10 - list[3]) // 10 works somehow, i thought it should be 10_000_000
        })
        .collect();

    let mut links: Vec<Vec<(usize, usize)>> = vec![Vec::new(); n];

    for &(u, v, c) in &edges {
        links[u].push((v, c));
        links[v].push((u, c));
    }

    let mut costs: Vec<Option<usize>> = vec![None; n];
    let mut queue: BinaryHeap<(Reverse<usize>, usize)> = BinaryHeap::new();
    queue.push((Reverse(0), 0));

    while let Some((Reverse(c), u)) = queue.pop() {
        match costs[u] {
            Some(u_cost) if u_cost <= c => continue,
            _ => costs[u] = Some(c),
        };

        for (v, v_cost) in &links[u] {
            match costs[*v] {
                Some(v_cost) if v_cost <= c + v_cost => continue,
                _ => queue.push((Reverse(c + v_cost), *v)),
            }
        }
    }

    match costs[n - 1] {
        Some(cost) => {
            let trees = 10 - (cost % 10);
            let real = (cost + trees) / 10;
            println!("{} {}", real, trees);
        }
        None => panic!("Could not find path"),
    }
}
