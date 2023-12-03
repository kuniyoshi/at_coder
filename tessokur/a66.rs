use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, q): (usize, usize) = {
        let parts: Vec<usize> = lines
            .next()
            .unwrap()
            .unwrap()
            .split_whitespace()
            .map(|s| s.parse().unwrap())
            .collect();
        (parts[0], parts[1])
    };

    let mut union_find = UnionFind::new(n);

    for _ in 0..q {
        let (op, u, v): (usize, usize, usize) = {
            let parts: Vec<usize> = lines
                .next()
                .unwrap()
                .unwrap()
                .split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect();
            (parts[0], parts[1] - 1, parts[2] - 1)
        };

        match op {
            1 => {
                union_find.unite(u, v);
            },
            2 => {
                println!(
                    "{}",
                    if union_find.root(u) == union_find.root(v) {
                        "Yes"
                    } else {
                        "No"
                    }
                );
            },
            _ => panic!("unknown op: {}", op),
        }
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
