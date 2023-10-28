use std::collections::HashSet;
use std::fmt::Debug;
use std::io::{self, BufRead};
use std::str::FromStr;

fn main() {
    let n: usize = ReadTiny::read_one();
    let points: Vec<(usize, usize)> = ReadTiny::read_doubles(n);
    let mut distances = vec![vec![0f64; n]; n];

    for i in 0..n {
        for j in 0..n {
            distances[i][j] = if j == i {
                std::f64::MAX
            } else {
                distance(&points[i], &points[j])
            };
        }
    }

    let mut visited = HashSet::<usize>::new();
    let mut current = 0;
    let mut next = closest_vertex(&distances[0], &visited);
    let mut total = 0f64;
    let mut history = Vec::new();

    while visited.len() != n {
        eprintln!("{} -> {}", current, next);
        assert!(next != current, "next != current");
        total += distances[current][next];
        visited.insert(current);
        history.push(current);

        current = next;
        next = closest_vertex(&distances[current], &visited);

        if visited.len() == n - 1 {
            total += distances[next][0];
            visited.insert(next);
            history.push(next);
        }
    }

    for v in &history {
        println!("{}", v + 1);
    }

    println!("{}", 1);
}

fn closest_vertex(distances: &Vec<f64>, visited: &HashSet<usize>) -> usize {
    let (closest, _) = distances
        .iter()
        .enumerate()
        .filter(|&(index, _)| !visited.contains(&index))
        .min_by(|(_, &a), (_, &b)| a.partial_cmp(&b).expect("Could not compare"))
        .expect("Could not find min");
    closest
}

fn distance(a: &(usize, usize), b: &(usize, usize)) -> f64 {
    let dx = (b.0 as f64) - (a.0 as f64);
    let dy = (b.1 as f64) - (a.1 as f64);
    f64::sqrt(dx * dx + dy * dy)
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
