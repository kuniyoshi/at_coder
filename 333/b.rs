use fmt::Debug;
use std::collections::HashMap;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let mut s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();
    let mut t: Vec<char> = lines.next().unwrap().unwrap().chars().collect();
    s.sort();
    t.sort();

    println!("{}", yes_no(length(&s) == length(&t)));
}

fn length(ab: &Vec<char>) -> usize {
    let candidate = ab[1] as usize - ab[0] as usize;
    match candidate {
        1 => 1,
        2 => 2,
        3 => 2,
        4 => 1,
        _ => panic!("unexpected case"),
    }
}

fn yes_no(is_yes: bool) -> &'static str {
    if is_yes {
        "Yes"
    } else {
        "No"
    }
}
