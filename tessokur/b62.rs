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

    for i in 0..m {
        let (a, b) = edges[i];
        neighbors[a].push(b);
        neighbors[b].push(a);
    }

    let mut paths: Vec<usize> = Vec::new();
    paths.push(0);
    let mut visited: HashSet<usize> = HashSet::new();
    visited.insert(0);

    dfs(&neighbors, &mut visited, &mut paths);

    println!(
        "{}",
        paths
            .iter()
            .map(|u| u + 1)
            .map(|x| x.to_string())
            .collect::<Vec<String>>()
            .join(" ")
    );
}

fn dfs(neighbors: &Vec<Vec<usize>>, visited: &mut HashSet<usize>, paths: &mut Vec<usize>) -> bool {
    if visited.contains(&(neighbors.len() - 1)) {
        return true;
    }

    for neighbor in &neighbors[*paths.last().unwrap()] {
        if visited.contains(&neighbor) {
            continue;
        }

        visited.insert(*neighbor);
        paths.push(*neighbor);

        let result = dfs(neighbors, visited, paths);

        if result {
            return true;
        }

        visited.remove(neighbor);
        paths.pop();
    }

    false
}
