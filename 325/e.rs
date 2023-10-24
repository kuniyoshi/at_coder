use std::io::{self, BufRead};
use std::collections::BinaryHeap;
use std::cmp::Reverse;

fn main() {
    let (n, a, b, c) = read_four();
    let cities = read_tuple(n);

    let mut heap = BinaryHeap::new();
    heap.push((Reverse(0), 0));

    let mut time = vec![usize::MAX; n];

    while let Some((Reverse(cost), u)) = heap.pop() {
        if u == n - 1 {
            println!("{}", cost);
            return;
        }

        if cost >= time[u] {
            continue;
        }

        time[u] = cost;

        for i in 0..n {
            heap.push((Reverse(cities[u][i] * a), i));
            heap.push((Reverse(cities[u][i] * b + c), i));
        }
    }
}

fn read_tuple(n: usize) -> Vec<Vec<usize>> {
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();

    let mut result = Vec::new();

    for _ in 0..n {
        let line = lines.next().unwrap().unwrap();
        let parts: Vec<usize> = line.split_whitespace().map(|s| s.parse().unwrap()).collect();
        result.push(parts);
    }

    result
}


fn read_four() -> (usize, usize, usize, usize) {
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: usize = parts.next().unwrap().parse().unwrap();
    let b: usize = parts.next().unwrap().parse().unwrap();
    let c: usize = parts.next().unwrap().parse().unwrap();
    let d: usize = parts.next().unwrap().parse().unwrap();

    (a, b, c, d)
}
