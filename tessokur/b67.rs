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
    let mut edges: Vec<(usize, usize, usize)> = (0..m)
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

    edges.sort_by(|a, b| b.2.cmp(&a.2));

    let mut union_find = UnionFind::new(n);
    let mut total: usize = 0;

    for &(u, v, cost) in &edges {
        if union_find.root(u) == union_find.root(v) {
            continue;
        }

        union_find.unite(u, v);
        total += cost;
    }

    println!("{}", total);
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
