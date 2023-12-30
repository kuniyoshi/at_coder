use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, x): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    if a.last().unwrap() == &x {
        println!("{}", n);
        return;
    }

    let mut ac: usize = 0;
    let mut wa: usize = n - 1;

    while wa - ac > 1 {
        let wj = (ac + wa) / 2;
        if a[wj] <= x {
            ac = wj;
        }
        else {
            wa = wj;
        }
    }

    println!("{}", ac + 1);
}