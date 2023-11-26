use std::collections::VecDeque;
use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let parts: Vec<usize> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();
    let (n, m) = (parts[0], parts[1]);
    let edges: Vec<_> = (0..m)
        .map(|_| {
            let parts: Vec<usize> = lines
                .next()
                .unwrap()
                .unwrap()
                .split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect();

            (parts[0] - 1, parts[1] - 1)
        })
        .collect();

    let mut neighbors: Vec<Vec<usize>> = vec![Vec::new(); n];

    for (a, b) in &edges {
        neighbors[*a].push(*b);
        neighbors[*b].push(*a);
    }

    let mut costs: Vec<usize> = vec![usize::MAX; n];
    let mut queue: VecDeque<usize> = VecDeque::new();
    costs[0] = 0;
    queue.push_back(0);

    while let Some(u) = queue.pop_front() {
        for neighbor in &neighbors[u] {
            if costs[*neighbor] <= costs[u] + 1 {
                continue;
            }

            costs[*neighbor] = costs[u] + 1;
            queue.push_back(*neighbor);
        }
    }

    for cost in &costs {
        if *cost == usize::MAX {
            println!("-1");
        } else {
            println!("{}", *cost);
        }
    }
}
