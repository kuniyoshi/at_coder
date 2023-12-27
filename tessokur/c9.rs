use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    let mut last_worked: usize = 0;
    let mut last_dont: usize = 0;

    for i in 0..n {
        let worked = last_dont + a[i];
        let dont = last_worked.max(last_dont);

        last_worked = worked;
        last_dont = dont;
    }

    println!("{}", last_worked.max(last_dont));
}