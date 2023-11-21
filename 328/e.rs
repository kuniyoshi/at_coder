use fmt::Debug;
use std::cmp;
use std::fmt;
use std::io::{self, BufRead};
use std::str;
use std::collections::HashSet;

struct P {
    n: usize,
    m: usize,
    k: usize,
    edges: Vec<(usize, usize, usize)>,
}

fn cost(used: &HashSet<usize>, p: &P) -> usize {
    let mut cost: usize = 0;

    for i in used {
        cost += p.edges[*i].2 % p.k;
    }

    cost % p.k
}

fn is_tree(used: &HashSet<usize>, p: &P) -> bool {
    let mut union_find: UnionFind = UnionFind::new(p.n);

    for i in used {
        if union_find.root(p.edges[*i].0) == union_find.root(p.edges[*i].1) {
            return false;
        }
        union_find.unite(p.edges[*i].0, p.edges[*i].1);
    }

    true
}

fn dfs(used: &mut HashSet<usize>, p: &P) -> Option<usize> {
    if used.len() == p.n - 1 {
        return if is_tree(&used, p) {
            Some(cost(used, p))
        } else {
            None
        };
    }

    let mut min: Option<usize> = None;

    for i in 0..p.m {
        if used.contains(&i) {
            continue;
        }

        used.insert(i);

        min = min_or(min, dfs(used, p));

        used.remove(&i);
    }

    min
}

fn min_or(a: Option<usize>, b: Option<usize>) -> Option<usize> {
    match (a, b) {
        (Some(a_value), Some(b_value)) => Some(cmp::min(a_value, b_value)),
        (Some(_), _) => a,
        (_, _) => b,
    }
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, m, k): (usize, usize, usize) = read_three(&mut lines);
    let edges: Vec<(usize, usize, usize)> = (0..m)
        .map(|_| {
            let (a, b, c): (usize, usize, usize) = read_three(&mut lines);
            (a - 1, b - 1, c)
        })
        .collect();

    let mut used: HashSet<usize> = HashSet::new();

    println!("{}", dfs(&mut used, &P { n, m, k, edges }).unwrap());
}

fn read_three<A: str::FromStr, B: str::FromStr, C: str::FromStr>(
    lines: &mut io::Lines<io::StdinLock>,
) -> (A, B, C)
where
    A::Err: Debug + 'static,
    B::Err: Debug + 'static,
    C::Err: Debug + 'static,
{
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: A = parts.next().unwrap().parse().unwrap();
    let b: B = parts.next().unwrap().parse().unwrap();
    let c: C = parts.next().unwrap().parse().unwrap();
    (a, b, c)
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
