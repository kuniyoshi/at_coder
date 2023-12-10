use std::collections::HashMap;
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
            (list[0] - 1, list[1] - 1, list[2])
        })
        .collect();

    let mut graph: Vec<Vec<usize>> = vec![Vec::new(); n];
    let mut capacity: HashMap<(usize, usize), usize> = HashMap::new();

    for &(u, v, cost) in &edges {
        graph[u].push(v);
        capacity.insert((u, v), cost);
    }

    let mut max_flow: usize = 0;
    let mut parent: Vec<Option<usize>> = vec![None; n];
    let mut visited = vec![false; n];

    while dfs(&graph, &mut capacity, 0, n - 1, &mut visited, &mut parent) {
        let mut path_flow = usize::MAX;
        let mut current = 0;

        while let Some(p) = parent[current] {
            for v in &graph[p] {
                if *v == current && capacity.get(&(p, *v)).unwrap() > &0 {
                    path_flow = path_flow.min(*capacity.get(&(p, *v)).unwrap());
                }
            }

            current = p;
        }

        max_flow += path_flow;
        visited.fill(false);
        parent.fill(None);
    }

    println!("{}", max_flow);
}

fn dfs(
    graph: &Vec<Vec<usize>>,
    capacity: &mut HashMap<(usize, usize), usize>,
    u: usize,
    t: usize,
    visited: &mut Vec<bool>,
    parent: &mut Vec<Option<usize>>,
) -> bool {
    visited[u] = true;

    if t == u {
        return true;
    }

    for v in &graph[u] {
        if !visited[*v] && capacity.get(&(u, *v)).unwrap() > &0 {
            parent[*v] = Some(u);

            if dfs(graph, capacity, *v, t, visited, parent) {
                return true;
            }
        }
    }

    false
}
