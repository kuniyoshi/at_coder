use std::io::{self, BufRead};
use std::collections::BinaryHeap;
use std::cmp::Reverse;


fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let stages: Vec<(usize, usize, usize)> = (0..(n-1)).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1], list[2])
    }).collect();

    let mut queue: BinaryHeap<(Reverse<usize>, usize)> = BinaryHeap::new();
    let mut distance: Vec<Option<usize>> = vec![None; n];

    queue.push((Reverse(0), 0));

    while let Some((next, to)) = queue.pop() {
        match distance[to] {
            Some(to_value) if to_value <= next.0 => continue,
            _ => {
                distance[to] = Some(next.0);
                if to == n - 1 {
                    continue;
                }
                match distance[to + 1] {
                    Some(to_value) if to_value <= next.0 + stages[to].0 => (),
                    _ => queue.push((
                        Reverse(next.0 + stages[to].0),
                        to + 1
                    )),
                };
                match distance[stages[to].2 - 1] {
                    Some(to_value) if to_value <= next.0 + stages[to].1 => (),
                    _ => queue.push((Reverse(next.0 + stages[to].1), stages[to].2 - 1)),
                }
            },
        }
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", distance);

    println!("{}", distance.last().unwrap().unwrap());
}