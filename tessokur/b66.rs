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
    let edges: Vec<(usize, usize)> = (0..m).map(|_| {
        let parts: Vec<usize> = lines
            .next()
            .unwrap()
            .unwrap()
            .split_whitespace()
            .map(|s| s.parse().unwrap())
            .collect();
        (parts[0] - 1, parts[1] - 1)
    }).collect();

    let mut union_find = UnionFind::new(n);

    for &(u, v) in &edges {
        union_find.unite(u, v);
    }

    let q: usize = lines.next().unwrap().unwrap().parse().unwrap();

    for _ in 0..q {
        let parts: Vec<usize> = lines
            .next()
            .unwrap()
            .unwrap()
            .split_whitespace()
            .map(|s| s.parse().unwrap())
            .collect();

        match parts[0] {
            1 => {}
            2 => {}
            _ => panic!("unknown op: {}", parts[0]),
        };
    }
}

pub struct UnionFind {
    parents: Vec<usize>,
    sizes: Vec<usize>,
}

impl UnionFind {
    pub fn new(n: usize) -> Self {
        let parents = (0..n).collect::<Vec<usize>>();
        let sizes: Vec<usize> = vec![1; n];
        UnionFind { parents, sizes }
    }

    pub fn root(&mut self, v: usize) -> usize {
        if self.parents[v] == v {
            v
        } else {
            self.root(self.parents[v])
        }
    }

    pub fn unite(&mut self, u: usize, v: usize) {
        let root_u = self.root(u);
        let root_v = self.root(v);
        if root_u == root_v {
            return;
        }

        if self.sizes[root_u] > self.sizes[root_v] {
            self.parents[root_v] = u;
            self.sizes[root_u] += self.sizes[root_v];
        } else {
            self.parents[root_u] = v;
            self.sizes[root_v] += self.sizes[root_u];
        }
    }

    pub fn disconnect(&mut self, u: usize, v: usize) {
        let root_u = self.root(u);
        let root_v = self.root(v);
        if root_u == root_v {
            return;
        }

        if self.sizes[root_u] > self.sizes[root_v] {
            self.parents[root_v] = u;
            self.sizes[root_u] += self.sizes[root_v];
        } else {
            self.parents[root_u] = v;
            self.sizes[root_v] += self.sizes[root_u];
        }

    }
}
