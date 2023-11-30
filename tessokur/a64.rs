use std::cmp::Reverse;
use std::collections::BinaryHeap;
use std::io::{self, BufRead};

struct Edge {
    a: usize,
    b: usize,
    cost: usize,
}

impl Edge {
    pub fn new(v: Vec<usize>) -> Self {
        Edge {
            a: v[0] - 1,
            b: v[1] - 1,
            cost: v[2],
        }
    }
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
    let (n, m): (usize, usize) = (nm[0], nm[1]);
    let edges: Vec<Edge> = (0..m)
        .map(|_| {
            Edge::new(
                lines
                    .next()
                    .unwrap()
                    .unwrap()
                    .split_whitespace()
                    .map(|s| s.parse().unwrap())
                    .collect(),
            )
        })
        .collect();

    let mut neighbors: Vec<Vec<(usize, usize)>> = vec![Vec::new(); n];

    for edge in &edges {
        neighbors[edge.a].push((edge.b, edge.cost));
        neighbors[edge.b].push((edge.a, edge.cost));
    }

    let mut costs: Vec<Option<usize>> = vec![None; n];

    let mut heap: BinaryHeap<(Reverse<usize>, usize)> = BinaryHeap::new();
    heap.push((Reverse(0), 0));

    while let Some((Reverse(c), u)) = heap.pop() {
        match costs[u] {
            Some(current) if c >= current => {
                continue;
            }
            Some(_) => {
                costs[u] = Some(c);
            }
            None => {
                costs[u] = Some(c);
            }
        }

        for i in 0..neighbors[u].len() {
            match costs[neighbors[u][i].0] {
                Some(current) if current <= c + neighbors[u][i].1 => {
                    continue;
                }
                None | Some(_) => {
                    // do nothing
                }
            }

            heap.push((Reverse(c + neighbors[u][i].1), neighbors[u][i].0));
        }
    }

    for i in 0..n {
        match costs[i] {
            Some(cost) => {
                println!("{}", cost);
            }
            None => {
                println!("-1");
            }
        }
    }
}
