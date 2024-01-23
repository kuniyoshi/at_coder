use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let mut lr: Vec<(usize, usize)> = (0..n).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    }).collect();

    lr.sort_by(|a, b| a.1.cmp(&b.1));

    #[cfg(debug_assertions)]
    eprintln!("{:?}", lr);

    let mut total: usize = 0;
    let mut now: usize = 0;

    for &(l, r) in &lr {
        if l >= now {
            total += 1;
            now = r;
        }
    }

    println!("{}", total);
}