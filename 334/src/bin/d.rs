use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, q): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };
    let mut r: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
    let queries: Vec<usize> = (0..q).map(|_| { lines.next().unwrap().unwrap().parse().unwrap() }).collect();

    r.sort();

    let mut acc = vec![0];

    for i in 0..r.len() {
        acc.push(acc[i] + r[i]);
    }

    for query in &queries {
        if query >= acc.last().unwrap() {
            println!("{}", n);
            continue;
        }

        let mut ac = 0;
        let mut wa = n;

        while wa - ac > 1 {
            let wj = (ac + wa) / 2;

            if acc[wj] <= *query {
                ac = wj;
            } else {
                wa = wj;
            }
        }

        println!("{}", ac);
    }
}