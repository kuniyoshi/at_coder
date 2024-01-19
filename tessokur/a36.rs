use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, k): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };

    if k % 2 == 1 {
        println!("No");
        return;
    }

    // 2 -> 2
    // 3 -> 4
    // 4 -> 6
    if k < 2 * (n - 1) {
        println!("No");
        return;
    }

    println!("{}", if k % 2 == 0 { "Yes" } else { "No" });
}