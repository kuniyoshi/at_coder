use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();

    println!("{}", n);

    for i in 0..n {
        if i == n - 1 {
            println!("{} {}", i + 1, 1);
        }
        else {
            println!("{} {}", i + 1, i + 2);
        }
    }
}