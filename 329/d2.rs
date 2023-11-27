use fmt::Debug;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

struct Person {
    votes: usize,
    index: usize,
}

impl Person {
    pub fn is_greater_than(self: &Self, other: &Person) -> bool {
        self.votes > other.votes || (self.votes == other.votes && self.index < other.index)
    }
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, m): (usize, usize) = read_two(&mut lines);
    let a: Vec<usize> = read_list(&mut lines);

    let mut votes: Vec<usize> = vec![0; n];
    let mut max = Person { votes: 0, index: 0 };

    for i in 0..m {
        votes[a[i] - 1] += 1;
        let other = Person {
            votes: votes[a[i] - 1],
            index: a[i] - 1,
        };

        max = if other.is_greater_than(&max) {
            other
        } else {
            max
        };

        println!("{}", max.index + 1);
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
