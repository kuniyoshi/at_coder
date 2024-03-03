use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();

    print!("1");

    for _ in 0..n {
        print!("01");
    }

    println!("");
}
