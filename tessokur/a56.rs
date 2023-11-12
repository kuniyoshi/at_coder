use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, q) = read_two(&mut lines);
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();

    for _ in 0..q {
        let (a, b, c, d) = read_four(&mut lines);
        
        println!("a, b, c, d: {}, {}, {}, {}", a, b, c, d);
    }
}



fn read_two(lines: &mut std::io::Lines<std::io::StdinLock>) -> (usize, usize) {
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: usize = parts.next().unwrap().parse().unwrap();
    let b: usize = parts.next().unwrap().parse().unwrap();
    (a, b)
}

fn read_four(lines: &mut std::io::Lines<std::io::StdinLock>) -> (usize, usize, usize, usize) {
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: usize = parts.next().unwrap().parse().unwrap();
    let b: usize = parts.next().unwrap().parse().unwrap();
    let c: usize = parts.next().unwrap().parse().unwrap();
    let d: usize = parts.next().unwrap().parse().unwrap();
    (a, b, c, d)
}