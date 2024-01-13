use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();

    let three = n / 3;
    let five = n / 5;
    let fifteen = n / 15;

    println!("{}", three + five - fifteen);
}