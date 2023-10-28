use std::fmt::Debug;
use std::io::{self, BufRead};
use std::str::FromStr;

fn main() {
    let (x, y): (i32, i32) = ReadTiny::read_two();
    if y > x {
        println!("{}", YesNo::get(y - x <= 2));
    }
    else {
        println!("{}", YesNo::get(x - y <= 3));
    }
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

    fn read_lines(n: usize) -> Vec<String> {
        let mut lines = io::stdin().lock().lines();
        let mut result = Vec::new();

        for _ in 0..n {
            result.push(lines.next().unwrap().unwrap());
        }

        result
    }

    pub fn read_one<T>() -> T
    where
        T: FromStr,
        T::Err: Debug,
    {
        let line = ReadTiny::read_line();
        line.parse().expect("Could not parse")
    }

    pub fn read_two<S, T>() -> (S, T)
    where
        S: FromStr,
        S::Err: Debug,
        T: FromStr,
        T::Err: Debug,
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
        (s, t)
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

    pub fn read_doubles<T, U>(n: usize) -> Vec<(T, U)>
    where
        T: FromStr,
        T::Err: Debug,
        U: FromStr,
        U::Err: Debug,
    {
        let mut lines = io::stdin().lock().lines();
        let mut result = Vec::new();

        for _ in 0..n {
            let line = lines.next().unwrap().unwrap();
            let mut parts = line.split_whitespace();
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
            result.push((t, u));
        }

        result
    }

    pub fn read_triples<S, T, U>(n: usize) -> Vec<(S, T, U)>
    where
        S: FromStr,
        S::Err: Debug,
        T: FromStr,
        T::Err: Debug,
        U: FromStr,
        U::Err: Debug,
    {
        let mut lines = io::stdin().lock().lines();
        let mut result = Vec::new();

        for _ in 0..n {
            let line = lines.next().unwrap().unwrap();
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
            result.push((s, t, u));
        }

        result
    }

    pub fn read_values<T>() -> Vec<T>
    where
        T: FromStr,
        T::Err: Debug,
    {
        let line = ReadTiny::read_line();
        line.split_whitespace()
            .map(|s| s.parse().expect("Could not parse"))
            .collect()
    }

    pub fn read_chars(n: usize) -> Vec<Vec<char>> {
        let mut lines = io::stdin().lock().lines();
        let mut result = Vec::new();

        for _ in 0..n {
            let line = lines.next().unwrap().unwrap();
            result.push(line.chars().collect());
        }

        result
    }

    pub fn read_matrix<T>(n: usize) -> Vec<Vec<T>>
    where
        T: FromStr,
        T::Err: Debug,
    {
        let mut lines = io::stdin().lock().lines();
        let mut result = Vec::new();

        for _ in 0..n {
            let line = lines.next().unwrap().unwrap();
            let row: Vec<T> = line
                .split_whitespace()
                .map(|s| s.parse().expect("Could not parse"))
                .collect();
            result.push(row);
        }

        result
    }
}