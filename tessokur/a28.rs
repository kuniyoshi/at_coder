use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let commands: Vec<String> = (0..n).map(|_| {
        lines.next().unwrap().unwrap()
    }).collect();

    let mut value = 0;

    for command in commands.iter() {
        let parts: Vec<&str> = command.split_whitespace().collect();
        let operator = parts[0];
        let number = parts[1].parse::<i64>().unwrap();

        match operator {
            "+" => value += number,
            "-" => value -= number,
            "*" => value *= number,
            _ => panic!("Unknown operator: {}", operator)
        }

        value %= 10_000;
        println!("{}", if value < 0 { value + 10_000 } else { value });
    }
}