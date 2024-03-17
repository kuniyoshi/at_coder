use std::collections::HashMap;
use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
    let q: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let queries: Vec<Vec<usize>> = (0..q).map(|_| {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        list
    }).collect();

    let mut previous = HashMap::new();
    let mut next = HashMap::new();

    for i in 1..n {
        previous.insert(a[i], a[i - 1]);
    }

    for i in 0..(n -1) {
        next.insert(a[i], a[i + 1]);
    }

    for query in &queries {
        match query[0] {
            1 => { // insert
                let x = query[1];
                let y = query[2];
                // previous -> y -> next
                // next[x] -> y
                // previous[y] -> x
                // previous[next[x]] -> y
                next.insert(x, y);
            },
            2 => { // delete

            },
            _ => unreachable!(),
        }
    }

    let mut cursor = *previous.values().next().unwrap();

    while previous.contains_key(&cursor) {
        cursor = previous[&cursor];
    }

    print!("{} ", cursor);

    while next.contains_key(&cursor) {
        cursor = next[&cursor];
        print!("{} ", cursor);
    }

    println!("");
}
