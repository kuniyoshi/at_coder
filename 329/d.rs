use fmt::Debug;
use std::cmp::Reverse;
use std::collections::BinaryHeap;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, m): (usize, usize) = read_two(&mut lines);
    let a: Vec<usize> = read_list(&mut lines);

    let mut heap: BinaryHeap<(usize, Reverse<usize>)> = BinaryHeap::new();
    let mut votes: Vec<usize> = vec![0; n];

    for i in 0..m {
        votes[a[i] - 1] += 1;
        heap.push((votes[a[i] - 1], Reverse(a[i] - 1)));
        let (_, top) = heap.peek().unwrap();
        println!("{}", top.0 + 1);
    }
}

fn read_list<A: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> Vec<A>
where
    A::Err: Debug + 'static,
{
    let line = lines.next().unwrap().unwrap();
    line.split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect()
}

fn read_two<A: str::FromStr, B: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> (A, B)
where
    A::Err: Debug + 'static,
    B::Err: Debug + 'static,
{
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: A = parts.next().unwrap().parse().unwrap();
    let b: B = parts.next().unwrap().parse().unwrap();
    (a, b)
}
