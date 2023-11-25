use std::io::{self, BufRead};

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
    let mut total: usize = 0;

    for i in 0..n {
        let count = segment_tree.query(a[i]);
        // println!("{}, {}, {}", i, a[i], count);
        // eprintln!("{:?}", segment_tree.dump());
        segment_tree.set(a[i]);
        total += count;
    }

    println!("{}", total);
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

    pub fn set(&mut self, at: usize) {
        self.tree[at + self.size - 1] += 1;

        let mut index = at + self.size - 1;

        while index != 1 {
            index /= 2;
            self.tree[index] = self.tree[index * 2] + self.tree[index * 2 + 1];
        }
    }

    pub fn dump(&self) -> &Vec<usize> {
        &self.tree
    }

    pub fn query(&self, i: usize) -> usize {
        let mut index = i + self.size - 1;
        let mut count: usize = 0;

        while index != 1 {
            let parent = index / 2;

            count += if parent * 2 == index {
                self.tree[parent * 2 + 1]
            } else {
                0
            };

            index = parent;
        }

        count
    }
}
