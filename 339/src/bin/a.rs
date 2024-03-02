use std::io::{self, BufRead};

fn main() {
    let stdin = io::stdin();
    let input = stdin.lock().lines().next().unwrap().unwrap();

    let output = input.rsplit_once('.').map_or_else(|| input.as_str(), |(_, after_dot)| after_dot);

    println!("{}", output);
}
