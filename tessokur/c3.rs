use std::io::{self, BufRead};
use std::cmp::Ordering;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let d: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let a: Vec<i64> = (0..d)
        .map(|_| {
            let a: i64 = lines.next().unwrap().unwrap().parse().unwrap();
            a
        })
        .collect();
    let q: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let st: Vec<(usize, usize)> = (0..q)
        .map(|_| {
            let list: Vec<usize> = lines
                .next()
                .unwrap()
                .unwrap()
                .split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect();
            (list[0], list[1])
        })
        .collect();

    let mut values: Vec<i64> = Vec::new();
    let mut acc: i64 = 0;

    for i in 0..a.len() {
        acc += a[i];
        values.push(acc);
    }

    for i in 0..st.len() {
        let (s, t) = st[i];
        match values[s - 1].cmp(&values[t - 1]) {
            Ordering::Less => println!("{}", t),
            Ordering::Equal => println!("Same"),
            Ordering::Greater => println!("{}", s),
        }
    }
}
