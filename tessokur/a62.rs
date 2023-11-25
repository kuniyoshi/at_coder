use std::collections::HashSet;
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
    let (n, m): (usize, usize) = (parts[0], parts[1]);
    let edges: Vec<(usize, usize)> = (0..m)
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

    for (u, v) in edges.iter() {
        neighbors[*u].push(*v);
        neighbors[*v].push(*u);
    }

    let mut visited: HashSet<usize> = HashSet::new();

    dfs(0, &neighbors, &mut visited);

    if visited.len() == n {
        println!("The graph is connected.");
    } else {
        println!("The graph is not connected.");
    }
}

fn dfs(v: usize, neighbors: &Vec<Vec<usize>>, visited: &mut HashSet<usize>) {
    if visited.contains(&v) {
        return;
    }

    visited.insert(v);

    for i in neighbors[v].iter() {
        if visited.contains(i) {
            continue;
        }

        dfs(*i, neighbors, visited);
    }
}
