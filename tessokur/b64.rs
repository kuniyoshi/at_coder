use std::cmp::Reverse;
use std::collections::VecDeque;
use std::io::{self, BufRead};

macro_rules! array_to_tuple2 {
    ($arr:expr) => {
        ($arr[0], $arr[1])
    };
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let nm: Vec<usize> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();
    let (n, m): (usize, usize) = array_to_tuple2!(nm);
    let edges: Vec<(usize, usize, usize)> = (0..m)
        .map(|_| {
            let parts: Vec<usize> = lines
                .next()
                .unwrap()
                .unwrap()
                .split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect();
            (parts[0] - 1, parts[1] - 1, parts[2])
        })
        .collect();

    let mut neighbors: Vec<Vec<(usize, usize)>> = vec![Vec::new(); n];

    for &(u, v, cost) in &edges {
        neighbors[u].push((v, cost));
        neighbors[v].push((u, cost));
    }

    let mut costs: Vec<Option<usize>> = vec![None; n];

    let mut queue: VecDeque<(Reverse<usize>, usize)> = VecDeque::new();
    queue.push_back((Reverse(0), 0));

    while let Some((Reverse(cost), u)) = queue.pop_front() {
        match costs[u] {
            Some(c) if c <= cost => continue,
            _ => costs[u] = Some(cost),
        };

        for &(v, c) in &neighbors[u] {
            match costs[v] {
                Some(next_cost) if next_cost <= c + cost => continue,
                _ => queue.push_back((Reverse(c + cost), v)),
            }
        }
    }

    let mut paths: Vec<usize> = vec![n - 1; 1];

    while paths.last() != Some(&0) {
        let last = paths.last().unwrap();
        for &(v, c) in &neighbors[*last] {
            if costs[*last].unwrap() >= c && costs[v].unwrap() == costs[*last].unwrap() - c {
                paths.push(v);
                break;
            }
        }
    }

    for path in paths.iter().rev() {
        print!("{} ", path + 1);
    }

    println!("");
}
