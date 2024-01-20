use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (d, n): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };
    let spans: Vec<(usize, usize, usize)> = (0..n).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0] - 1, list[1] - 1, list[2])
    }).collect();

    let mut hours: Vec<usize> = vec![24; d];

    for &(l, r, h) in &spans {
        for i in l..=r {
            hours[i] = hours[i].min(h);
        }
    }

    println!("{}", hours.iter().sum::<usize>());
}