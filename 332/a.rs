use fmt::Debug;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, s, k): (usize, usize, usize) = read_three(&mut lines);
    let items: Vec<(usize, usize)> = (0..n).map(|_| read_two(&mut lines)).collect();
    let sum: usize = items.iter().map(|(cost, count)| cost * count).sum();
    let sending = if sum >= s { 0 } else { k };
    println!("{}", sum + sending);
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
