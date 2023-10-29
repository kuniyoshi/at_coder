use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let n: usize = parts.next().unwrap().parse().unwrap();
    let x: usize = parts.next().unwrap().parse().unwrap();
    let mut a: Vec<char> = lines.next().unwrap().unwrap().chars().collect();

    a[x - 1] = '@';

    for i in x..n {
        if a[i] == '.' {
            a[i] = '@';
        } else {
            break;
        }
    }

    for i in (0..=(x - 2)).rev() {
        if a[i] == '.' {
            a[i] = '@';
        } else {
            break;
        }
    }

    let a_string: String = a.into_iter().collect();
    println!("{}", a_string);
}
