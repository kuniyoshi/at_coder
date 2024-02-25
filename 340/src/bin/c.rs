use std::io::{self, BufRead};

static mut MEMO: Option<std::collections::HashMap<usize, usize>> = None;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();

    unsafe {
        MEMO = Some(std::collections::HashMap::new());
    }

    println!("{}", r(n));
}

fn r(n: usize) -> usize {
    unsafe {
        let memo = MEMO.as_mut().unwrap();

        if let Some(&result) = memo.get(&n) {
            return result;
        }

        let l = lbin(n);
        let u = ubin(n);

        let result = if l > 1 && u > 1 {
            n + r(l) + r(u)
        } else if l > 1 {
            n + r(l)
        } else if u > 1 {
            n + r(u)
        } else {
            n
        };

        memo.insert(n, result);
        result
    }
}

fn lbin(n: usize) -> usize {
    n / 2
}

fn ubin(n: usize) -> usize {
    (n + 1) / 2
}