use std::io::{self, BufRead};
use std::cmp;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let _: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    // 2 3 1 6 4 5
    //     1  2  3  4  5  6
    //     0  0  0  0  0  0
    // 2:  0  1  0  0  0  0
    // 3:  0  1  2  0  0  0
    // 1:  1  1  2  0  0  0
    // 6:  1  1  2  0  0  3
    // 4:  1  1  2  3  0  3
    // 5:  1  1  2  3  4  3

    //             1
    //       2          3
    //    4    5     6     7
    //  8  9 10 11 12 13 14 15

    //                          1  2  3  4  5  6  7  8
    // [0, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0]
    let mut segtree: SegmentTree = SegmentTree::new(*a.iter().max().unwrap());

    for value in &a {
        if *value == 1 {
            segtree.set(*value, 1);
            continue;
        }

        let max = segtree.query(1, *value);
        let new_value = max.map_or(1, |v| v + 1);
        segtree.set(*value, new_value);
    }

    println!("{}", segtree.max());

    segtree.dump();
}

// index: 0 は無効です。
// 1 ベースの番号にデータを持ちます。
struct SegmentTree {
    size: usize,
    tree: Vec<usize>,
}

impl SegmentTree {
    pub fn new(n: usize) -> Self {
        let mut size: usize = 1;
        while size < n {
            size *= 2;
        }

        SegmentTree {
            size,
            tree: vec![0; 2 * size],
        }
    }

    pub fn set(&mut self, at: usize, value: usize) {
        self.tree[at + self.size - 1] = value;

        let mut index = at + self.size - 1;

        while index != 1 {
            index /= 2;
            self.tree[index] = cmp::max(self.tree[index * 2], self.tree[index * 2 + 1]);
        }
    }

    pub fn dump(&self) -> &Vec<usize> {
        &self.tree
    }

    pub fn query(&self, l: usize, r: usize) -> Option<usize> {
        self.query_impl(l, r, 1, self.size + 1, 1)
    }

    fn query_impl(
        &self,
        l: usize,
        r: usize,
        a: usize,
        b: usize,
        cell_number: usize,
    ) -> Option<usize> {
        // [a, b) が [l, r) の外にある場合は値を返せません
        if b <= l || a >= r {
            return None;
        }

        // [a, b) が [l, r) に完全に含まれている場合は今のセルを返します
        if a >= l && b <= r {
            return Some(self.tree[cell_number]);
        }

        let m = (a + b) / 2;

        // a か b のどちらかは [l, r) に含まれています
        return Self::max_or(
            self.query_impl(l, r, a, m, cell_number * 2),
            self.query_impl(l, r, m, b, cell_number * 2 + 1),
        );
    }

    fn max_or(a: Option<usize>, b: Option<usize>) -> Option<usize> {
        match (a, b) {
            (Some(a_value), Some(b_value)) => Some(cmp::max(a_value, b_value)),
            (Some(_), None) => a,
            (None, _) => b,
        }
    }

    pub fn max(&self) -> usize {
        self.tree[1]
    }
}