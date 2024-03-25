use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, q): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();
    let queries: Vec<(usize, usize, usize)> = (0..q).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1], list[2])
    }).collect();

    let mut tree = FenwickTree::new(n + 1);

    for i in 0..(s.len() - 1) {
        if s[i] == s[i + 1] {
            tree.update(i + 1, 1);
        }
    }

    for &(op, l, r) in &queries {
        match op {
            1 => {
                if l > 1 {
                    tree.flip(l - 1);
                }
                if r < n {
                    tree.flip(r);
                }
            }
            2 => {
                match tree.sum(r - 1) - tree.sum(l - 1) {
                    value if value == 0 => println!("Yes"),
                    _ => println!("No"),
                }
            }
            _ => unreachable!()
        }
    }

}

struct FenwickTree {
    tree: Vec<i64>,
}

impl FenwickTree {
    fn new(size: usize) -> Self {
        FenwickTree { tree: vec![0; size + 1] }
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

    fn value(&self, index: usize) -> i64 {
        self.sum(index) - self.sum(index - 1)
    }

    fn flip(&mut self, index: usize) {
        match self.value(index) {
            0 => self.update(index, 1),
            1 => self.update(index, -1),
            _ => unreachable!(),
        };
    }
}