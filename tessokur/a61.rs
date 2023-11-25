use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let n: usize = parts.next().unwrap().parse().unwrap();
    let m: usize = parts.next().unwrap().parse().unwrap();
    let edges: Vec<(usize, usize)> = (0..m)
        .map(|_| {
            let items: Vec<usize> = lines
                .next()
                .unwrap()
                .unwrap()
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

    for i in 0..n {
        println!("{}: {{{}}}", i + 1, neighbors[i].iter().map(|&x| x.to_string()).collect::<Vec<String>>().join(", "));
    }
}
