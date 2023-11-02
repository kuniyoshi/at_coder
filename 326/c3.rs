use std::io::{self, BufRead};
use std::cmp;

fn main() {
    let stdin = io::stdin().lock();
    let mut lines = stdin.lines();
    let (_, m) = read_two(&mut lines);
    let mut a = read_numbers(&mut lines);
    a.sort();

    let mut from = 0;
    let mut to = 0;
    let mut max = 0;

    while to != a.len() {
        while to < a.len() && (to < from || a[to] < a[from] + m) {
            to += 1;
        }

        max = cmp::max(max, to - from);
    
        from += 1;
    }

    println!("{}", max);
}

fn read_numbers(lines: &mut io::Lines<io::StdinLock>) -> Vec<usize> {
    let line = lines.next().unwrap().unwrap();
    line.split_whitespace().map(|s| s.parse().unwrap()).collect()
}

fn read_two(lines: &mut io::Lines<io::StdinLock>) -> (usize, usize) {
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: usize = parts.next().unwrap().parse().unwrap();
    let b: usize = parts.next().unwrap().parse().unwrap();
    (a, b)
}
