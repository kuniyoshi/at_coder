use std::io::{self, BufRead};
use std::collections::HashMap;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let a: Vec<i32> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    // 6
    // 4 1 -1 5 3 2

    #[cfg(debug_assertions)]
    eprintln!("{:?}", a);

    let mut previous: HashMap<i32, usize> = HashMap::new();

    let mut first: Option<usize> = None;

    for i in 0..a.len() {
        previous.insert(a[i], i + 1);

        if a[i] == -1 {
            first = Some(i + 1);
        }
    }

    let mut cursor: usize = first.unwrap();
    let mut orders: Vec<usize> = vec![cursor];

    while orders.len() != n {
        cursor = previous[&(cursor as i32)];
        orders.push(cursor);
    }

    for i in 0..orders.len() {
        print!("{} ", orders[i])
    }

    println!("");
}