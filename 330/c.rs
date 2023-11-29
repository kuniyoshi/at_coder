use fmt::Debug;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let d: i64 = read_one(&mut lines);
    let max: i64 = 2 * 10_i64.pow(6);

    let mut min: i64 = i64::MAX;

    for i in 0..max {
        let center = (((d - i * i).abs() as f64).sqrt()) as i64;

        for j in -1..=1 {
            min = min.min((i * i + (center + j) * (center + j) - d).abs());
        }
    }

    println!("{}", min);
}

fn read_one<A: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> A
where
    A::Err: Debug + 'static,
{
    lines.next().unwrap().unwrap().parse().unwrap()
}
