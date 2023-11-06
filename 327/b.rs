use fmt::Debug;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let b: usize = read_one(&mut lines);
    println!("{}", test(b));
}

fn test(b: usize) -> isize {
    for i in 1..=15 {
        if (i as isize).pow(i) == b as isize {
            return i as isize;
        }
    }

    -1
}

fn read_one<A: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> A
where
    A::Err: Debug + 'static,
{
    lines.next().unwrap().unwrap().parse().unwrap()
}
