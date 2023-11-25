use std::cmp;
use std::io::{self, BufRead};

//        6
//    6       4
//  6   5   4   0
// 6 2 5 3 1 4 0 0
// - 6 6 4 6 5 4 0 6 2 5 3 1 4 0 0
// 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5
fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let a: Vec<usize> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();

    let mut segment_tree = SegmentTree::new(n);

    for i in 0..n {
        // eprintln!("{:?}", segment_tree.dump());

        let kisanbi = segment_tree.query(a[i]);

        if let Some(k) = kisanbi {
            println!("{}", k);
        } else {
            println!("-1")
        };

        segment_tree.set(i + 1, a[i]);
    }
}

// index: 0 は無効です。
// 1 ベースの番号にデータを持ちます。
struct SegmentTree {
    size: usize,
    // - 1 2 3 4 5 6 7 8 9 10 11
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

    // [1]            6
    // [2, 3]     6       4
    // [4, 7]   6   5   4   0
    // [8, 15] 6 2 5 3 1 4 0 0
    // - 6 6 4 6 5 4 0 6 2 5 3 1 4 0 0
    // 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5
    pub fn query(&self, value: usize) -> Option<usize> {
        if self.tree[1] <= value {
            return None;
        }

        let mut number: usize = 1;

        while number * 2 + 1 < 2 * self.size {
            if self.tree[number * 2 + 1] > value {
                number = number * 2 + 1;
            } else {
                assert!(self.tree[number * 2] > value);
                number = number * 2;
            }
        }

        Some(number + 1 - self.size)
    }
}
