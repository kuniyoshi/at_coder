use fmt::Debug;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    // mississippi
    //  ??oo?oo?oo?
    // 000011122333
    let mut lines = io::stdin().lock().lines();
    let (n, q): (usize, usize) = read_two(&mut lines);
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();

    let mut acc: Vec<usize> = Vec::new();
    acc.push(0);
    acc.push(0);

    for i in 1..n {
        if s[i - 1] == s[i] {
            acc.push(acc[acc.len() - 1] + 1);
        } else {
            acc.push(acc[acc.len() - 1]);
        }
    }

    for _ in 0..q {
        let (l, r): (usize, usize) = read_two(&mut lines);
        let count: usize = acc[r] - acc[l];
        println!("{}", count);
    }
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
