use std::{collections::HashSet, io::{self, BufRead}};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (_, k): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    let mut set = HashSet::new();

    for value in &a {
        set.insert(value);
    }

    let mut values: Vec<_> = set.iter().collect();
    values.sort();

    let mut previous = 0;
    let mut total = 0;

    // (previous, current)
    // {1, 3, 6} | k = 5
    for &value in &values {
        if **value > k {
            break;
        }

        if **value - 1 > previous {
            total += sum(**value - 1) - sum(previous);
        }

        previous = **value;
    }

    if k > previous {
        total += sum(k) - sum(previous);
    }

    println!("{}", total);
}

fn sum(a: usize) -> usize {
    // 1 2 3 4 5 -> 
    a * (a + 1) / 2
}