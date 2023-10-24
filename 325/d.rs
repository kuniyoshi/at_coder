use std::collections::BinaryHeap;
use std::collections::VecDeque;
use std::io::{self, BufRead};

fn main() {
    let n = read_single();
    let items = sorted(read_tuple(n));

    let mut heap = BinaryHeap::new();
    let mut time = 0;
    let mut count = 0;

    for [a, b] in items {
        let end_at = a + b;
        heap.push(Reverse(end_at));

        // 取れなかったものを捨てる
        while heap.len() && ( Some(peek) = heap.peek() ) < time {
            heap.pop();
        }

        // 取れる分だけとる
        while heap.len() && ( Some(peek) = heap.peek() ) {
            if Some(top) = heap.pop() {
            }
        }
        println!("{}, {}", a, b);
    }

    println!("{}", count);
}

fn sorted(mut items: Vec<[usize; 2]>) -> VecDeque<[usize; 2]> {
    items.sort();
    VecDeque::from(items)
}

fn read_tuple(n: usize) -> Vec<[usize; 2]> {
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();

    let mut result = Vec::new();

    for _ in 0..n {
        let line = lines.next().unwrap().unwrap();
        let mut parts = line.split_whitespace();
        let a = parts.next().unwrap().parse().unwrap();
        let b = parts.next().unwrap().parse().unwrap();

        result.push([a, b]);
    }

    result
}

fn read_single() -> usize {
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();

    lines.next().unwrap().unwrap().parse().unwrap()
}
