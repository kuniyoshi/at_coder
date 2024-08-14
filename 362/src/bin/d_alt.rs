use std::cmp::Reverse;
use std::collections::{BinaryHeap, HashSet};

fn main() {
    proconio::input! {
        n: usize,
        m: usize,
        a: [u64; n],
        edges: [(usize, usize, u64); m],
    };

    let mut links: Vec<Vec<(usize, u64)>> = vec![Vec::new(); n];

    for &(u, v, cost) in &edges {
        links[u - 1].push((v - 1, cost + a[v - 1]));
        links[v - 1].push((u - 1, cost + a[u - 1]));
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", links);

    let mut queue = BinaryHeap::new();
    queue.push((Reverse(a[0]), 0_usize));

    let mut visited = HashSet::new();

    let mut costs = vec![None; n];

    while let Some((Reverse(cost), u)) = queue.pop() {
        if visited.contains(&u) {
            continue;
        }

        if let Some(existing_cost) = costs[u] {
            if existing_cost <= cost {
                continue;
            }
        }

        costs[u] = Some(cost);
        visited.insert(u);

        for &(v, c) in &(links[u]) {
            if visited.contains(&v) {
                continue;
            }

            if let Some(existing_cost) = costs[v] {
                if existing_cost <= c + cost {
                    continue;
                }
            }

            queue.push((Reverse(c + cost), v));
        }
    }

    for i in 1..n {
        print!("{} ", costs[i].unwrap());
    }

    println!("");
}
