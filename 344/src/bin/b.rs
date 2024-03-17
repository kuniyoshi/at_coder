use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let mut numbers = Vec::new();

    loop {
        let line = lines.next().unwrap().unwrap();
        numbers.push(line.clone());
        if line == "0" {
            break;
        }
    }

    numbers.reverse();

    for number in numbers {
        println!("{}", number);
    }
}
