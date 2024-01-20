use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let lr: Vec<(usize, usize)> = (0..n).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    }).collect();

    let mut events: Vec<(usize, usize)> = Vec::new();

    let mut total: usize = 0;

    for i in 0..lr.len() {
        events.push((lr[i].0, i));
        events.push((lr[i].1, i));
    }

    events.sort();

    #[cfg(debug_assertions)]
    eprintln!("{:?}", events);

    let mut did_begins: Vec<bool> = vec![false, n];

    

    println!("{}", total);
}