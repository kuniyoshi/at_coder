use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();

    println!("{}", ctz(n));
}

fn ctz(mut value: usize) -> usize {
    let mut count = 0;

    while value > 0 {
        if value % 2 == 1 {
            break;
        }

        count += 1;
        value >>= 1;
    }

    count
}