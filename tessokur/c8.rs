use std::io::{self, BufRead};
use std::collections::HashMap;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let classes: Vec<(usize, usize)> = (0..n)
        .map(|_| {
            let a: Vec<usize> = lines
                .next()
                .unwrap()
                .unwrap()
                .split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect();
            (a[0], a[1])
        })
        .collect();

    let mut class_of: HashMap<usize, usize> = HashMap::new();

    for &(u, class) in &classes {
        class_of.insert(u, class);
    }

    let mut neighbors: Vec<Vec<usize>> = vec![Vec::new(); 10_000];

    for &(u, class) in &classes {
        if class != 2 {
            continue;
        }

        for i in 0..4 {
            for j in 0..=9 {

            }
        }
    }
    
    // 1649
    // 2649 2
    // 3649
    // 4649
    // 5649
    // 6649
    // 7649
    // 8649
    // 9649
    // 4749 2
    // 
    // 1234
    // 2234
    // 1334
    // 1244
    // 1233

    for i in 0..=9999 {
        match class_of.entry(i) {
            Some(class) if class == 1 => {
                println!("{}", i);
                return;
            }
            Some(class) => 
        }
    }

}
