use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, _): (usize, usize) = {
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

    // data: 1 1 1 1 1
    // acc:  1 2 3 4 5

    // query: 3
    // acc: 1 2 0 4 5
    // acc: 2 2 0 5 6
    // data: 2 0 -2 5 1

    // query: 5
    // acc: 4 3 1 6 1
    // data: 4 -1 -2 5 -5

    // query: 1
    // acc: 0 4 2 7 2
    // data: 0 4 -2 5 -5

    for i in &b {
        let box_number = i + 1;

        #[cfg(debug_assertions)]
        eprintln!("box_number: {:?}", box_number);
        
        let acc = tree.sum(box_number);
        let whole = acc / n as i64;

        #[cfg(debug_assertions)]
        eprintln!("acc: {:?}", acc);

        #[cfg(debug_assertions)]
        eprintln!("whole: {:?}", whole);

        assert!(acc >= 0);
        assert!(whole >= 0);

        tree.clear_acc(box_number);
        tree.update(1, whole);
        let remain = acc as usize % n;

        #[cfg(debug_assertions)]
        eprintln!("remain: {:?}", remain);

        if remain == 0 {
            continue;
        }
        if box_number + 1 <= n {
            tree.update(box_number + 1, 1);
        }
        if box_number + remain < n {
            tree.update(box_number + 1 + remain, -1);
        }
        if box_number + remain > n {
            tree.update(1, 1);
            tree.update(box_number + 1 + remain - n, -1);
        }

        #[cfg(debug_assertions)]
        tree.dump_acc();
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

    #[cfg(debug_assertions)]
    fn dump_acc(&self) {
        for i in 1..self.tree.len() {
            eprint!("{} ", self.sum(i));
        }
        eprintln!("");
    }
}
