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

    fn value(&self, index: usize) -> i64 {
        self.sum(index) - self.sum(index - 1)
    }

    fn flip(&mut self, index: usize) {
        match self.value(index) {
            0 => self.update(index, 1),
            v => self.update(index, -v),
        };
    }
}

fn main() {
    let count = 5;
    let mut tree = FenwickTree::new(count);

    tree.update(1, 1);

    for i in 1..=count {
        println!("{} {}", i, tree.value(i));
    }

    println!("---");

    tree.flip(5);

    for i in 1..=count {
        println!("{} {}", i, tree.value(i));
    }

    println!("---");

    tree.flip(5);

    for i in 1..=count {
        println!("{} {}", i, tree.value(i));
    }
}
