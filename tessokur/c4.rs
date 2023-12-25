use std::io::{self, BufRead};
use std::collections::HashSet;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();

    let mut set: HashSet<usize> = HashSet::new();

    for i in 1..=n {
        if i * i > n {
            break;
        }

        if n % i == 0 {
            set.insert(i);
            set.insert(n / i);
        }
    }

    let mut sorted_set: Vec<usize> = set.into_iter().collect();
    sorted_set.sort();

    for &num in &sorted_set {
        println!("{}", num);
    }
}