use fmt::Debug;
use std::collections::HashMap;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();

    for i in 0..n {
        print!("{}", n);
    }

    println!("");
}
