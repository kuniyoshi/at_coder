use std::io::{self, BufRead};
use std::str::FromStr;

fn main() {
    let (n, q): (usize, usize) = read_two();
    let mut lines = io::stdin().lock().lines();
    let mut is_reverse = false;

    let mut values: Vec<usize> = (1..=n).collect();

    for _ in 0..q {
        let parts: Vec<String> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.to_string()).collect();
        if parts[0] == "1" {
            let (x, y): (usize, usize) = (parts[1].parse().unwrap(), parts[2].parse().unwrap());
            values[if is_reverse { n - x } else { x - 1 }] = y;
        }
        else if parts[0] == "2" {
            is_reverse = !is_reverse;
        }
        else if parts[0] == "3" {
            let index: usize = parts[1].parse().unwrap();
            println!("{}", values[if is_reverse { n - index } else { index - 1 }]);
        }
        else {
            panic!("クエリに問題があります");
        }
    }
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
