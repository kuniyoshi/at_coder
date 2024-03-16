use std::io::{self, BufRead};
use std::cmp::Ordering;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let p: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
    let q: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let queries: Vec<(usize, usize)> = (0..q).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0] - 1, list[1] - 1)
    }).collect();

    let mut positions = vec![0; n];

    for i in 0..n {
        positions[p[i] - 1] = i;
    }

    for &(a, b) in &queries {
        match positions[a].cmp(&positions[b]) {
            Ordering::Less    => println!("{}", a + 1),
            Ordering::Greater => println!("{}", b + 1),
            _ => unreachable!()
        }
    }
}
