use fmt::Debug;
use std::collections::HashSet;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let _: usize = read_one(&mut lines);
    let d: Vec<usize> = read_list(&mut lines);
    let count: usize = d
        .iter()
        .enumerate()
        .map(|(index, days)| t(index + 1, *days))
        .sum();
    println!("{}", count);
}

fn t(month: usize, days: usize) -> usize {
    (1..=days)
        .map(|d: usize| {
            let mut chars: HashSet<char> = month.to_string().chars().collect();
            for b in d.to_string().chars() {
                chars.insert(b);
            }
            if chars.len() == 1 {
                1
            } else {
                0
            }
        })
        .sum()
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

fn read_one<A: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> A
where
    A::Err: Debug + 'static,
{
    lines.next().unwrap().unwrap().parse().unwrap()
}
