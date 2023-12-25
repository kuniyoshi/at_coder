use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();

    for i in (0..10).rev() {
        print!("{}", if 1 << i & (n - 1) > 0 { 7 } else { 4 });
    }

    println!("");
}
