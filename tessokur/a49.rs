use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let t: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let pqr: Vec<(usize, usize, usize)> = (0..t).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0] - 1, list[1] - 1, list[2] - 1)
    }).collect();

    #[cfg(debug_assertions)]
    eprintln!("{:?}", pqr);

    let mut counts: Vec<Vec<usize>> = vec![Vec::new(); 20];

    for i in 0..t {
        counts[pqr[i].0].push(i);
        counts[pqr[i].1].push(i);
        counts[pqr[i].2].push(i);
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", counts);

    let mut operations: Vec<Option<usize>> = vec![None; t];

    for i in 0..counts.len() {
        if counts[i] % 2 == 1 {
            continue;
        }


    }
}