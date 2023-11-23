use std::cmp;
use std::io::{self, BufRead};

struct P {
    l: usize,
    r: usize,
    x: Vec<usize>,
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, l, r): (usize, usize, usize) = read_three(&mut lines);
    let x: Vec<usize> = read_list(&mut lines);

    let p = P { x, l, r };

    let mut segment_tree = SegmentTree::new(n);

    for i in 1..=n {
        segment_tree.set(i, if i == 1 { 0 } else { n });
    }
    eprintln!("{:?}", segment_tree.dump());

    for i in 1..n {
        let from = bin_l(i - 1, &p) + 1;
        let to = bin_r(i - 1, &p) + 1;
        // println!("{}, {}", from, to);

        segment_tree.set(
            from,
            option_min(
                segment_tree.query(from, from),
                option_add(segment_tree.query(i, i), 1),
            ),
        );
        segment_tree.set(
            to,
            option_min(
                segment_tree.query(to, to),
                option_add(segment_tree.query(i, i), 1),
            ),
        );
    }

    eprintln!("{:?}", segment_tree.dump());

    println!("{}", segment_tree.query(n, n).unwrap());
}

fn option_add(a: Option<usize>, b: usize) -> usize {
    let value = a.map_or(0, |v| v);
    value + b
}

fn option_min(a: Option<usize>, b: usize) -> usize {
    match a {
        Some(a_value) => cmp::min(a_value, b),
        _ => b,
    }
}

fn bin_r(i: usize, p: &P) -> usize {
    if p.x[i] + p.r >= *p.x.last().unwrap() {
        return p.x.len() - 1;
    }

    let mut ac = i;
    let mut wa = p.x.len() - 1;

    while wa - ac > 1 {
        let wj = (ac + wa) / 2;
        if p.x[wj] <= p.x[i] + p.r {
            ac = wj;
        } else {
            wa = wj;
        }
    }

    ac
}

fn bin_l(i: usize, p: &P) -> usize {
    let mut ac: usize = p.x.len() - 1;
    let mut wa: usize = i;

    while ac - wa > 1 {
        let wj = (ac + wa) / 2;
        if p.x[wj] >= p.x[i] + p.l {
            ac = wj;
        } else {
            wa = wj;
        }
    }

    ac
}

fn read_list(lines: &mut io::Lines<io::StdinLock>) -> Vec<usize> {
    let line = lines.next().unwrap().unwrap();
    line.split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect()
}

fn read_three(lines: &mut io::Lines<io::StdinLock>) -> (usize, usize, usize) {
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: usize = parts.next().unwrap().parse().unwrap();
    let b: usize = parts.next().unwrap().parse().unwrap();
    let c: usize = parts.next().unwrap().parse().unwrap();
    (a, b, c)
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

    pub fn at(&mut self, at: usize) -> usize {
        self.tree[at + self.size - 1]
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
            (Some(a_value), Some(b_value)) => Some(cmp::min(a_value, b_value)),
            (Some(_), None) => a,
            (None, _) => b,
        }
    }
}
