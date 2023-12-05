use std::collections::HashSet;
use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, m): (usize, usize) = {
        let parts: Vec<usize> = lines
            .next()
            .unwrap()
            .unwrap()
            .split_whitespace()
            .map(|s| s.parse().unwrap())
            .collect();
        (parts[0], parts[1])
    };
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
    let q: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let queries: Vec<Vec<usize>> = (0..q)
        .map(|_| {
            lines
                .next()
                .unwrap()
                .unwrap()
                .split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect()
        })
        .collect();

    let mut to_be_removed: HashSet<usize> = HashSet::new();

    for query in &queries {
        if query[0] == 1 {
            to_be_removed.insert(query[1] - 1);
        }
    }

    let mut union_find = UnionFind::new(n);

    for i in 0..edges.len() {
        if to_be_removed.contains(&i) {
            continue;
        }

        let (u, v) = edges[i];

        union_find.unite(u, v);
    }

    let mut answers: Vec<&str> = Vec::new();

    for query in queries.iter().rev() {
        match query[0] {
            1 => {
                let (u, v) = edges[query[1] - 1];
                union_find.unite(u, v)
            }
            2 => {
                let (u, v) = (query[1], query[2]);
                answers.push(if union_find.root(u - 1) == union_find.root(v - 1) {
                    "Yes"
                } else {
                    "No"
                });
            }
            _ => panic!("unknown op: {:?}", query),
        };
    }

    for &answer in answers.iter().rev() {
        println!("{}", answer);
    }
}

pub struct UnionFind {
    parents: Vec<usize>,
}

impl UnionFind {
    pub fn new(n: usize) -> Self {
        let parents = (0..n).collect::<Vec<usize>>();
        UnionFind { parents }
    }

    pub fn root(&mut self, v: usize) -> usize {
        if self.parents[v] == v {
            v
        } else {
            self.parents[v] = self.root(self.parents[v]);
            self.parents[v]
        }
    }

    pub fn unite(&mut self, u: usize, v: usize) {
        let root_u = self.root(u);
        let root_v = self.root(v);
        if root_u == root_v {
            return;
        }

        self.parents[root_u] = root_v;
    }
}
