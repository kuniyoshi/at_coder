use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, k): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };
    
    let mut result: usize = 0;

    for i in 1..=n {
        for j in 1..=n {
            if i + j < k && k - (i + j) <= n {
                // println!("{} {} {}", i, j, k - i - j);
                result += 1;
            }
        }
    }

    println!("{}", result);
}