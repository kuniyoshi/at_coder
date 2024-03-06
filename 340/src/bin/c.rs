use std::collections::HashMap;
use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();

    let mut r = Recurse::new();

    println!("{}", r.r(n));
}

struct Recurse {
    memo: HashMap<usize, usize>,
}

impl Recurse {
    pub fn new() -> Self {
        Recurse {
            memo: HashMap::new(),
        }
    }

    pub fn r(self: &mut Self, n: usize) -> usize {
        if let Some(&result) = self.memo.get(&n) {
            return result;
        }

        let l = self.lbin(n);
        let u = self.ubin(n);

        let result = if l > 1 && u > 1 {
            n + self.r(l) + self.r(u)
        } else if l > 1 {
            n + self.r(l)
        } else if u > 1 {
            n + self.r(u)
        } else {
            n
        };

        self.memo.insert(n, result);
        result
    }

    fn lbin(self: &Self, n: usize) -> usize {
        n / 2
    }

    fn ubin(self: &Self, n: usize) -> usize {
        (n + 1) / 2
    }
}
