use std::io::{self, BufRead};
use std::cmp;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
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
    let mut segtree: SegmentTree = SegmentTree::new(n);

    for value in &a {
        if *value == 1 {
            segtree.set(*value, 1);
            continue;
        }

        let max = segtree.query(*value - 1);
        segtree.set(*value - 1, max + 1);
    }

    println!("{}", segtree.query(n));
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

    pub fn query(&self, at: usize) -> usize {
        let mut max: usize = 0;
        let mut cursor = at + self.size - 1;

        while cursor != 1 {
            cursor /= 2;
            max = max.max(self.tree[cursor * 2]);
        }

        max
    }

    pub fn dump(&self) -> &Vec<usize> {
        &self.tree
    }
}
