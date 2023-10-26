use std::io::{self, BufRead};
use std::str::FromStr;
use std::cmp;

fn main() {
    let (n, width): (usize, i32) = read_two();
    let mut students: Vec<(i32, i32)> = read_tuples(n);
    students.sort();
    let mut max = 0;

    for i in 0..students.len() {
        let min_a = students[i].0;

        for j in 0..students.len() {
            let min_b = students[j].1;

            let mut count = 0;

            for k in 0..students.len() {
                if students[k].0 >= min_a && students[k].0 <= min_a + width && students[k].1 >= min_b && students[k].1 <= min_b + width {
                    count += 1;
                }
            }

            max = cmp::max(max, count);
        }
    }

    println!("{}", max);
}

fn read_two<T: FromStr, U: FromStr>() -> (T, U)
where
    T::Err: std::fmt::Debug,
    U::Err: std::fmt::Debug,
{
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a = parts.next().unwrap().parse().expect("Failed to parse");
    let b = parts.next().unwrap().parse().expect("Failed to parse");
    (a, b)
}

fn read_tuples<T: FromStr>(n: usize) -> Vec<(T, T)>
where T::Err: std::fmt::Debug
{
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();
    let mut result = Vec::new();

    for i in 0..n {
        let line = lines.next().unwrap().unwrap();
        let mut parts: Vec<T> = line.split_whitespace().map(|s| s.parse().unwrap()).collect();

        if parts.len() != 2 {
            eprintln!("Error: Line {} does not contain exactly two elements.", i + 1);
            std::process::exit(1);
        }

        let a = parts.pop().unwrap();
        let b = parts.pop().unwrap();

        result.push((a, b));
    }

    result
}