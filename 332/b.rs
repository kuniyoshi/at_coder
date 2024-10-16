use fmt::Debug;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (k, g, m): (usize, usize, usize) = read_three(&mut lines);

    let mut grass: usize = 0;
    let mut mug: usize = 0;

    for _ in 0..k {
        if grass == g {
            grass = 0;
        }
        else if mug == 0 {
            mug = m;
        } else {
            let delta: usize = mug.min(g - grass);
            mug -= delta;
            grass += delta;
        }
    }

    println!("{} {}", grass, mug);
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
