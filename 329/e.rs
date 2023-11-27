use fmt::Debug;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, m): (usize, usize) = read_two(&mut lines);
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();
    let t: Vec<char> = lines.next().unwrap().unwrap().chars().collect();

    let mut passed: usize = n;

    for i in (0..n).rev() {
        if i > passed {
            continue;
        }

        for j in (0..m).rev() {
            s[i - j]
        }
    }

    println!("{}", yes_no(passed == 0));
}

fn yes_no(is_yes: bool) -> &'static str {
    if is_yes {
        "Yes"
    } else {
        "No"
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
