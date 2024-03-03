use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let mut a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
    let exchanges: Vec<(usize, usize)> = (0..(n - 1)).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    }).collect();

    for i in 0..(n-1) {
        a[i + 1] += (a[i] / exchanges[i].0) * exchanges[i].1;
    }

    println!("{}", a.last().unwrap());
}
