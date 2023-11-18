use std::cmp;
use std::io::{self, BufRead};

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
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, q): (usize, usize) = read_tuple(&mut lines);

    let mut segment_tree = SegmentTree::new(n);

    for _ in 0..q {
        match read_tuple3(&mut lines) {
            (1, pos, x) => {
                // println!("1: {}, {}", pos, x);
                segment_tree.set(pos, x);
            }
            (2, l, r) => {
                // eprintln!("2: {}, {}", l, r);
                println!("{}", segment_tree.query(l, r).unwrap());
            }
            (op, a, b) => panic!("Unknown input: {}, {}, {}", op, a, b),
        }
    }

    // eprintln!("{:?}", segment_tree.dump());
}

fn read_tuple3(lines: &mut io::Lines<io::StdinLock>) -> (usize, usize, usize) {
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: usize = parts.next().unwrap().parse().unwrap();
    let b: usize = parts.next().unwrap().parse().unwrap();
    let c: usize = parts.next().unwrap().parse().unwrap();
    (a, b, c)
}

fn read_tuple(lines: &mut io::Lines<io::StdinLock>) -> (usize, usize) {
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: usize = parts.next().unwrap().parse().unwrap();
    let b: usize = parts.next().unwrap().parse().unwrap();
    (a, b)
}
