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

fn main() {
    let mut union_find = UnionFind::new(5);
    union_find.unite(0, 1);
    union_find.unite(1, 2);
    union_find.unite(3, 3);

    for i in 0..5 {
        println!("root({}): {}", i, union_find.root(i));
    }
}