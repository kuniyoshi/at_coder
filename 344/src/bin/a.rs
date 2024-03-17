use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();

    let mut bar_count = 0;

    for c in &s {
        if c == &'|' {
            bar_count += 1;
        }
        if c == &'|' {
            continue;
        }
        if bar_count == 1 {
            continue;
        }

        print!("{}", c);
    }

    println!("");
}
