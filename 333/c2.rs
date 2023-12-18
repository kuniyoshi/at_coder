use std::cmp::Reverse;
use std::collections::{BinaryHeap, HashSet};
use std::io::{self, BufRead};

fn dfs(
    (a, b, c): (usize, usize, usize),
    used: &mut HashSet<(usize, usize, usize)>,
    set: &mut HashSet<usize>,
    numbers: &Vec<usize>,
) {
    if a == numbers.len() || b == numbers.len() || c == numbers.len() {
        return;
    }

    if used.contains(&(a, b, c)) {
        return;
    }

    used.insert((a, b, c));

    set.insert(numbers[a] + numbers[b] + numbers[c]);

    dfs((a + 1, b, c), used, set, numbers);
    dfs((a, b + 1, c), used, set, numbers);
    dfs((a, b, c + 1), used, set, numbers);
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let max_value: usize = 111_111_111_111;

    let mut numbers: Vec<usize> = Vec::new();
    let mut current: usize = 1;

    while current <= max_value {
        numbers.push(current);
        current = next_number(current);
    }

    let mut set: HashSet<usize> = HashSet::new();
    let mut used: HashSet<(usize, usize, usize)> = HashSet::new();

    dfs((0, 0, 0), &mut used, &mut set, &numbers);

    let mut heap: BinaryHeap<Reverse<usize>> = BinaryHeap::new();

    for element in &set {
        heap.push(Reverse(*element));
    }
    // eprintln!("{:?}", heap);

    for _ in 0..(n - 1) {
        heap.pop();
    }

    match heap.pop() {
        Some(Reverse(value)) => println!("{}", value),
        _ => panic!("Could not solve"),
    }
}

fn next_number(value: usize) -> usize {
    value * 10 + 1
}
