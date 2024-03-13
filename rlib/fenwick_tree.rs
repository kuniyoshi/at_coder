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

    fn clear_acc(&mut self, index: usize) {
        let before = self.sum(index);
        self.update(index, -before);
        if index + 1 <= self.tree.len() {
            self.update(index + 1, before);
        }
    }
}

fn main() {
    let values = [1, 2, 4, 8, 16];
    let mut tree = FenwickTree::new(values.len());

    for i in 0..values.len() {
        tree.update(i + 1, values[i] - tree.sum(i));
    }

    println!("### before");

    for i in 1..=values.len() {
        println!("{} {}", i, tree.sum(i));
    }

    tree.clear_acc(3);

    println!("--- clear");

    for i in 1..=values.len() {
        println!("{} {}", i, tree.sum(i));
    }

    println!("");

    for i in 1..=values.len() {
        println!("{} {}", i, tree.sum(i) - tree.sum(i - 1));
    }
}
