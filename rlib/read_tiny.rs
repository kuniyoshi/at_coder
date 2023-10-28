use std::fmt::Debug;
use std::io::{self, BufRead};
use std::str::FromStr;

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

fn main() {
    println!("read matrix 2x3");
    let i = ReadTiny::read_matrix::<usize>(2);
    for row in &i {
        for &col in row {
            println!("{}", col);
        }
    }

    println!("read chars");
    let h = ReadTiny::read_chars(2);
    for chars in &h {
        for &c in chars {
            println!("{}", c);
        }
    }

    println!("read values");
    let g: Vec<usize> = ReadTiny::read_values();
    for &x in &g {
        println!("{}", x);
    }

    println!("read triples x 2");
    let f: Vec<(usize, i32, u64)> = ReadTiny::read_triples(2);
    for &(s, t, u) in &f {
        println!("{}, {}, {}", s, t, u);
    }

    println!("read tuples x 3");
    let e: Vec<(usize, i32)> = ReadTiny::read_doubles(3);
    for &(t, u) in &e {
        println!("{}, {}", t, u);
    }

    println!("read lines");
    let d: Vec<String> = ReadTiny::read_lines(3);
    for line in d {
        println!("{}", line);
    }

    println!("read triple");
    let (c1, c2, c3): (usize, i32, u64) = ReadTiny::read_three();
    println!("{}, {}, {}", c1, c2, c3);

    println!("read double");
    let (b1, b2): (usize, i32) = ReadTiny::read_two();
    println!("{}, {}", b1, b2);

    println!("read single");
    let a: String = ReadTiny::read_one();
    println!("{}", a);
}
