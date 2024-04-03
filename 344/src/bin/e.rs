use std::collections::HashMap;
use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let a: Vec<usize> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();
    let q: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let queries: Vec<Vec<usize>> = (0..q)
        .map(|_| {
            let list: Vec<usize> = lines
                .next()
                .unwrap()
                .unwrap()
                .split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect();
            list
        })
        .collect();

    let mut previous = HashMap::new();
    let mut next = HashMap::new();

    for i in 1..n {
        previous.insert(a[i], a[i - 1]);
    }

    for i in 0..(n - 1) {
        next.insert(a[i], a[i + 1]);
    }

    previous.insert(a[0], 0);
    next.insert(0, a[0]);

    for query in &queries {
        match query[0] {
            // insert
            1 => {
                // x の直後に y を入れる
                let x = query[1];
                let y = query[2];
                // 「x の次」の前が y になる
                // x の次は y
                // y の次は「x の次」だったもの
                if let Some(&y_head_value) = next.get(&x) {
                    next.insert(y, y_head_value);
                    previous.insert(y_head_value, y);
                }
                next.insert(x, y);
                previous.insert(y, x);
            }
            2 => { // delete
                let x = query[1];
                // a x b
                match (previous.get(&x), next.get(&x)) {
                    // next[a] = b, previous[b] = a, 
                    (Some(&previous_value), Some(&next_value)) => {
                        next.insert(previous_value, next_value);
                        previous.insert(next_value, previous_value);
                    }
                    (Some(&previous_value), None) => {
                        next.remove(&previous_value);
                    }
                    (None, Some(&next_value)) => {
                        previous.remove(&next_value);
                    }
                    _ => unreachable!()
                }
                next.remove(&x);
                previous.remove(&x);
            }
            _ => unreachable!(),
        }
    }

    let mut cursor = 0;

    while next.contains_key(&cursor) {
        cursor = next[&cursor];
        print!("{} ", cursor);
    }

    println!("");
}
