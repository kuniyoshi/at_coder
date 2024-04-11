use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let x: i64 = lines.next().unwrap().unwrap().parse().unwrap();

    if x < 0 {
        println!("{}", x / 10);
    }
    else {
        println!("{}", (x + 9) / 10);
    }
}
