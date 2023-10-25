use std::io::{self, BufRead};

fn main() {
    let stdin = io::stdin();
    let line = stdin.lock().lines().next().unwrap().unwrap();
    let split = line.split_whitespace().collect::<Vec<&str>>();
    let (mut x, mut y): (i32, i32) = (split[0].parse().unwrap(), split[1].parse().unwrap());

    let mut history = Vec::<(i32, i32)>::new();

    // (x, y) <- (x - y, y) or (x, y - x)
    
    while x != 1 || y != 1 {
        history.push((x, y));

        if x > y {
            x -= y;
        }
        else {
            y -= x;
        }
    }

    if history.len() > 0 {
        println!("{}", history.len());

        for &(x, y) in history.iter().rev() {
            println!("{} {}", x, y);
        }
    }
    else {
        println!("{}", 0);
    }
}