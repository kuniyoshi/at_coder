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
}

fn main() {
    let values = [1, 2, 3, 4, 5];
    let mut tree = FenwickTree::new(values.len());


    for i in 0..values.len() {
        match i {
            0 => tree.update(i + 1, values[i]),
            _ => {
                let before = tree.sum(i);
                tree.update(i + 1, values[i] - before);
            }
        }
    }

    for i in 0..values.len() {
        println!("{} {}", i, tree.sum(i + 1));
    }
}