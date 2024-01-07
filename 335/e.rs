use std::io::{self, BufRead};
use std::collections::HashSet;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, m): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
    let edges: Vec<(usize, usize)> = (0..m).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0] - 1, list[1] - 1)
    }).collect();

    let mut links: Vec<Vec<usize>> = vec![Vec::new(); n];

    for &(u, v) in &edges {
        links[u].push(v);
        links[v].push(u);
    }

    let mut distances: Vec<usize> = vec![1_000_000_000; n];
    let mut queue: Vec<(usize, usize)> = vec![(0, 0)];

    while let Some((u, d)) = queue.pop() {
        if distances[u] <= d {
            continue;
        }

        distances[u] = d;

        for v in &links[u] {
            if distances[*v] <= d + 1 {
                continue;
            }

            queue.push((*v, d + 1));
        }
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", distances);
}