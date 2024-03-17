use std::collections::HashSet;
use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
    let m: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let b: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
    let l: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let c: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
    let q: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let x: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    let mut set = HashSet::new();

    for i in 0..n {
        for j in 0..m {
            for k in 0..l {
                set.insert(a[i] + b[j] + c[k]); 
            }
        }
    }

    for i in 0..q {
        if set.contains(&x[i]) {
            println!("Yes");
        } else {
            println!("No");
        }
    }
}
