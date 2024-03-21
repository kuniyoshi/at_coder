use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();
    let q: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let queries: Vec<(char, char)> = (0..q)
        .map(|_| {
            let list: Vec<char> = lines
                .next()
                .unwrap()
                .unwrap()
                .split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect();
            (list[0], list[1])
        })
        .collect();

    let mut lasts: Vec<_> = ('a'..='z').collect();

    for &(from, to) in &queries {
        for c in 'a'..='z' {
            if lasts[char_index(c)] == from {
                lasts[char_index(c)] = to;
            }
        }
    }

    for i in 0..n {
        print!("{}", lasts[char_index(s[i])]);
    }

    println!("");
}

fn char_index(c: char) -> usize {
    c as usize - 'a' as usize
}