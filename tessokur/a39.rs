use std::io::{self, BufRead};
use std::collections::BinaryHeap;

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

    let mut queue: BinaryHeap<(usize, usize)> = BinaryHeap::new();

    let mut total: usize = 0;
    let mut last: usize = 0;

    for i in 0..lr.len() {
        while let Some(end) = queue.peek() {
            if end.0 < lr[i].0 || end.0 < last {
                queue.pop();
                continue;
            }

            break;
        }

        match queue.peek() {
            Some(end) if lr[end.1].0 >= last => {
                last = lr[end.1].0;
                total += 1;
                queue.pop();
            },
            _ => (),
        };

        queue.push((lr[i].1, i));
    }

    println!("{}", total);
}