use fmt::Debug;
use std::collections::HashMap;
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
        if s[i-1] == s[i] {
            acc.push(acc[acc.len()-1] + 1);
        }
        else {
            acc.push(acc[acc.len()-1]);
        }
    }

    for _ in 0..q {
        let (l, r): (usize, usize) = read_two(&mut lines);
        let count: usize = acc[r] - acc[l];
        println!("{}", count);
    }
}

fn yes_no(is_yes: bool) -> &'static str {
    if is_yes {
        "Yes"
    } else {
        "No"
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

fn read_four<A: str::FromStr, B: str::FromStr, C: str::FromStr, D: str::FromStr>(
    lines: &mut io::Lines<io::StdinLock>,
) -> (A, B, C, D)
where
    A::Err: Debug + 'static,
    B::Err: Debug + 'static,
    C::Err: Debug + 'static,
    D::Err: Debug + 'static,
{
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: A = parts.next().unwrap().parse().unwrap();
    let b: B = parts.next().unwrap().parse().unwrap();
    let c: C = parts.next().unwrap().parse().unwrap();
    let d: D = parts.next().unwrap().parse().unwrap();
    (a, b, c, d)
}

fn read_three<A: str::FromStr, B: str::FromStr, C: str::FromStr>(
    lines: &mut io::Lines<io::StdinLock>,
) -> (A, B, C)
where
    A::Err: Debug + 'static,
    B::Err: Debug + 'static,
    C::Err: Debug + 'static,
{
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: A = parts.next().unwrap().parse().unwrap();
    let b: B = parts.next().unwrap().parse().unwrap();
    let c: C = parts.next().unwrap().parse().unwrap();
    (a, b, c)
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

fn read_one<A: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> A
where
    A::Err: Debug + 'static,
{
    lines.next().unwrap().unwrap().parse().unwrap()
}