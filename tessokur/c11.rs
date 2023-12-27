use std::cmp::Ordering;
use std::collections::BinaryHeap;
use std::io::{self, BufRead};

#[derive(PartialEq, Eq, Debug)]
struct Item {
    votes: usize,
    kth: usize,
    tou: usize,
}

impl Ord for Item {
    fn cmp(&self, other: &Self) -> Ordering {
        self.votes.cmp(&other.votes)
    }
}

impl PartialOrd for Item {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, k): (usize, usize) = {
        let list: Vec<usize> = lines
            .next()
            .unwrap()
            .unwrap()
            .split_whitespace()
            .map(|s| s.parse().unwrap())
            .collect();
        (list[0], list[1])
    };
    let a: Vec<usize> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();

    let mut heap: BinaryHeap<Item> = BinaryHeap::new();

    for i in 0..n {
        heap.push(Item {
            votes: a[i] * 1_000_000_000,
            kth: 1,
            tou: i,
        });
    }

    let mut seats: Vec<usize> = vec![0; n];
    let mut got: usize = 0;

    while got < k && heap.len() > 0 {
        match heap.pop() {
            Some(item) => {
                seats[item.tou] += 1;
                heap.push(Item {
                    votes: a[item.tou] * 1_000_000_000 / (item.kth + 1),
                    kth: item.kth + 1,
                    tou: item.tou,
                });
            }
            _ => panic!("unknown"),
        }

        got += 1;
    }

    for i in 0..n {
        print!("{} ", seats[i]);
    }
}
