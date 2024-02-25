use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let q: usize = lines.next().unwrap().unwrap().parse().unwrap();

    let mut a: Vec<usize> = Vec::new();

    for _ in 0..q {
        let (operation, xk): (usize, usize) = {
            let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
            (list[0], list[1])
        };

        match operation {
            1 => {
                a.push(xk);
            },
            2 => {
                println!("{}", a[a.len() - xk]);
            },
            _ => panic!("Unknown operation: {}", operation),
        };
    }
}
