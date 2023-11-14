use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let chars: Vec<char> = lines.next().unwrap().unwrap().chars().collect();
    let mut stack: Vec<char> = Vec::new();

    for i in 0..chars.len() {
        stack.push(chars[i]);

        if stack.ends_with(&['A', 'B', 'C']) {
            for _ in 0..3 {
                stack.pop();
            }
        }
    }

    println!("{}", stack.iter().collect::<String>());
}
