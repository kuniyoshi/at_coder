use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, k): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    let mut ac: usize = 1_000_000_000;
    let mut wa: usize = 0;

    while ac - wa > 1 {
        let wj = (ac + wa) / 2;
        if prints(wj, &a) >= k {
            ac = wj;
        }
        else {
            wa = wj;
        }
    }

    println!("{}", ac);
}

fn prints(time: usize, a: &Vec<usize>) -> usize {
    let mut total: usize = 0;

    for i in 0..a.len() {
        total += time / a[i];
    }

    total
}