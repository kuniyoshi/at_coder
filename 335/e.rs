use std::io::{self, BufRead};

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

    let mut union_find = UnionFind::new(n);

    let mut links: Vec<Vec<usize>> = vec![Vec::new(); n];

    for &(u, v) in &edges {
        if a[u] == a[v] {
            union_find.unite(u, v);
        }
    }

    for &(u, v) in &edges {
        if union_find.root(u) == union_find.root(v) {
            continue;
        }

        let (x, y) = match (a[u], a[v]) {
            (a, b) if a > b => (v, u),
            _ => (u, v),
        };

        links[union_find.root(x)].push(union_find.root(y));
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", links);

    let mut vertexes: Vec<usize> = (0..n).collect();
    vertexes.sort_by(|u, v| a[*u].cmp(&a[*v]));

    let mut dp: Vec<usize> = vec![0; n];

    dp[0] = 1;

    for u in vertexes.iter() {
        for v in links[*u].iter() {
            dp[*v] = dp[*v].max(dp[*u] + 1);
            // println!("{} -> {} {}", u, v, dp[*v]);
        }
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", dp);

    println!("{}", dp[n - 1]);
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
