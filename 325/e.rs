use std::io::{self, BufRead};
use std::collections::BinaryHeap;
use std::cmp::Reverse;

fn main() {
    let (n, a, b, c) = read_four();
    let cities = read_tuple(n);

    let mut heap = BinaryHeap::new();
    heap.push((Reverse(0), 0, 0));

    let mut time = vec![vec![usize::MAX; n]; 2];
    time[0][0] = 0;
    time[1][0] = 0;

    while let Some((Reverse(cost), u, how)) = heap.pop() {
        if cost > time[how][u] {
            continue;
        }

        for i in 0..n {
            if i == u {
                continue;
            }

            if how == 0 {
                let new_cost_car = cost + cities[u][i] * a;
                if new_cost_car < time[0][i] {
                    time[0][i] = new_cost_car;
                    heap.push((Reverse(new_cost_car), i, 0));
                }
            }

            let new_cost_train = cost + cities[u][i] * b + c;
            if new_cost_train < time[1][i] {
                time[1][i] = new_cost_train;
                heap.push((Reverse(new_cost_train), i, 1));
            }
        }
    }

    println!("{}", std::cmp::min(time[0][n - 1], time[1][n - 1]));
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
