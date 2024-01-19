use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, x, y): (usize, usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1], list[2])
    };
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    let mut is_wins: Vec<bool> = vec![false; a.iter().max().unwrap() + 1];

    for i in x..is_wins.len() {
        if i >= y {
            is_wins[i] = !is_wins[i - x] || !is_wins[i - y];
        } else {
            is_wins[i] = !is_wins[i - x];
        }
    }

    #[cfg(debug_assertions)]
    eprintln!("{:?}", is_wins);

    let mut win_count: usize = 0;
    let mut lose_count: usize = 0;

    for yama in a.iter() {
        if is_wins[*yama] {
            win_count += 1;
        } else {
            lose_count += 1;
        }
    }

    println!("{}, {}", win_count, lose_count);

    match (win_count % 2 == 0, lose_count % 2 == 0) {
        (false, true) => println!("First"),
        (false, false) => println!("Second"),
        (true, false) => println!("First"),
        (true, true) => println!("Second"),
    }
}