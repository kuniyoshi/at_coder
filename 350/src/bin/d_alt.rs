fn main() {
    proconio::input! {
        n: usize,
        m: usize,
        edges: [(usize, usize); m],
    };

    let mut tree = UnionFind::new(n);

    for &(from, to) in &edges {
        tree.unite(from - 1, to - 1);
    }

    let mut counts = vec![0; n];

    for &(from, _) in &edges {
        counts[tree.root(from - 1)] += 1;
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", counts);

    let mut sizes = vec![0; n];

    for i in 0..n {
        sizes[tree.root(i)] += 1;
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", sizes);

    let mut required = 0_usize;

    for i in 0..n {
        if sizes[i] > 0 {
            required += sizes[i] * (sizes[i] - 1) / 2 - counts[i];
        }
    }

    println!("{}", required);
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
