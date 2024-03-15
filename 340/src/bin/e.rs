use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, m): (usize, usize) = {
        let list: Vec<usize> = lines
            .next()
            .unwrap()
            .unwrap()
            .split_whitespace()
            .map(|s| s.parse().unwrap())
            .collect();
        (list[0], list[1])
    };
    let a: Vec<i64> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();
    let b: Vec<usize> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();

    let mut tree = FenwickTree::new(n);

    for i in 0..n {
        tree.update(i + 1, a[i] - tree.sum(i));
    }

    for i in 0..m {
        println!("{}", i);
        let whole = tree.sum(b[i] + 1) / n as i64;
        tree.clear_acc(b[i] + 1);
        tree.update(1, whole);
        let remain = whole as usize % n;
        if remain == 0 {
            continue;
        }
        if b[i] + 1 < n {
            tree.update(b[i + 1 + 1], 1);
        }
        if b[i] + remain < n {
            tree.update(b[i] + remain + 1 + 1, -1);
        }
        if b[i] + remain >= n {
            tree.update(1, 1);
            println!("{} {} {}", b[i], remain, n);
            tree.update(b[i] + 1 + remain - n, -1);
        }
    }

    for i in 1..=n {
        print!("{} ", tree.sum(i));
    }

    println!("");
}

struct FenwickTree {
    tree: Vec<i64>,
}

impl FenwickTree {
    fn new(size: usize) -> Self {
        FenwickTree {
            tree: vec![0; size + 1],
        }
    }

    fn update(&mut self, mut index: usize, value: i64) {
        while index < self.tree.len() {
            self.tree[index] += value;
            index += index & index.wrapping_neg();
        }
    }

    fn sum(&self, mut index: usize) -> i64 {
        let mut result = 0;
        while index > 0 {
            result += self.tree[index];
            index -= index & index.wrapping_neg();
        }
        result
    }

    fn clear_acc(&mut self, index: usize) {
        let before = self.sum(index);
        self.update(index, -before);
        if index + 1 <= self.tree.len() {
            self.update(index + 1, before);
        }
    }
}
