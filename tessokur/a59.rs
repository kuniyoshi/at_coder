use std::cmp;
use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let parts: Vec<usize> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();
    let (n, q) = (parts[0], parts[1]);

    let mut segment_tree = SegmentTree::new(n);

    for _ in 0..q {
        let items: Vec<usize> = lines
            .next()
            .unwrap()
            .unwrap()
            .split_whitespace()
            .map(|s| s.parse().unwrap())
            .collect();

        match (items[0], items[1], items[2]) {
            (op, pos, x) if op == 1 => {
                segment_tree.set(pos, x);
            }
            (op, l, r) if op == 2 => {
                if let Some(result) = segment_tree.query(l, r) {
                    println!("{}", result);
                } else {
                    panic!("no result: query = [{}, {}]", l, r);
                }
            }
            (_, _, _) => panic!("un supported operator"),
        }
    }
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
            self.tree[index] = self.tree[index * 2] + self.tree[index * 2 + 1];
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
        Some(
            self.query_impl(l, r, a, m, cell_number * 2)
                .map_or(0, |v| v)
                + self
                    .query_impl(l, r, m, b, cell_number * 2 + 1)
                    .map_or(0, |v| v),
        )
    }

    fn max_or(a: Option<usize>, b: Option<usize>) -> Option<usize> {
        match (a, b) {
            (Some(a_value), Some(b_value)) => Some(cmp::max(a_value, b_value)),
            (Some(_), None) => a,
            (None, _) => b,
        }
    }
}
