use std::fmt::Debug;
use std::io::{self, BufRead};
use std::str::FromStr;

fn main() {
    let (a, b, c): (i64, i64, i64) = ReadTiny::read_three();
    let sum = a + b + c;
    println!("{}", YesNo::get(sum == 0));
}

struct YesNo;

impl YesNo {
    pub fn get(is_yes: bool) -> String {
        if is_yes { "Yes".to_string() } else { "No".to_string() }
    }
}

pub struct ReadTiny;

impl ReadTiny {
    fn read_line() -> String {
        let stdin = io::stdin();
        let mut lines = stdin.lock().lines();
        lines.next().unwrap().unwrap()
    }

    pub fn read_three<S, T, U>() -> (S, T, U)
    where
        S: FromStr,
        S::Err: Debug,
        T: FromStr,
        T::Err: Debug,
        U: FromStr,
        U::Err: Debug,
    {
        let line = ReadTiny::read_line();
        let mut parts = line.split_whitespace();
        let s: S = parts
            .next()
            .expect("No split")
            .parse()
            .expect("Could not parse");
        let t: T = parts
            .next()
            .expect("No split")
            .parse()
            .expect("Could not parse");
        let u: U = parts
            .next()
            .expect("No split")
            .parse()
            .expect("Could not parse");
        (s, t, u)
    }
}