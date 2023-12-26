use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let mut c: Vec<usize> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();
    let q: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let x: Vec<usize> = (0..q)
        .map(|_| {
            let x: usize = lines.next().unwrap().unwrap().parse().unwrap();
            x
        })
        .collect();

    c.sort();

    let mut count: Vec<usize> = vec![0];

    for i in 0..n {
        count.push(c[i] + count.last().unwrap());
    }

    for query in &x {
        if query > count.last().unwrap() {
            println!("{}", count.len() - 1);
            continue;
        }

        let mut ac = 0;
        let mut wa = count.len() - 1;

        while wa - ac > 1 {
            let wj = (ac + wa) / 2;
            if count[wj] <= *query {
                ac = wj;
            } else {
                wa = wj;
            }
        }

        println!("{}", ac);
    }
}
