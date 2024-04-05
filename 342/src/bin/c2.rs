use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let _: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();
    let q: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let queries: Vec<(char, char)> = (0..q).map(|_| {
        let list: Vec<char> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    }).collect();

    let mut chars: Vec<char> = ('a'..='z').collect();

    for &(from, to) in &queries {
        for i in 0..chars.len() {
            if chars[i] == from {
                chars[i] = to;
            }
        }
    }

    for i in 0..s.len() {
        print!("{}", chars[s[i] as usize - 'a' as usize]);
    }

    println!("");
}