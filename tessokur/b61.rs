use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let line = lines.next().unwrap().unwrap();
    let parts: Vec<usize> = line
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();
    let (n, m): (usize, usize) = (parts[0], parts[1]);
    let edges: Vec<(usize, usize)> = (0..m)
        .map(|_| {
            let line = lines.next().unwrap().unwrap();
            let items: Vec<usize> = line
                .split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect();
            (items[0], items[1])
        })
        .collect();

    let mut neighbors: Vec<Vec<usize>> = vec![Vec::new(); n];

    for i in 0..m {
        let (a, b) = edges[i];
        neighbors[a - 1].push(b);
        neighbors[b - 1].push(a);
    }

    let max: usize = neighbors.iter().enumerate().max_by_key(|(_, v)| v.len()).map(|(i, _)| i).unwrap();

    println!("{}", max + 1);
}
