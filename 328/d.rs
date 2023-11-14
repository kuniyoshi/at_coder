use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let chars: Vec<char> = lines.next().unwrap().unwrap().chars().collect();
    let mut stack: Vec<char> = Vec::new();

    for i in 0..chars.len() {
        stack.push(chars[i]);

        if stack.len() >= 3
            && stack[stack.len() - 3] == 'A'
            && stack[stack.len() - 2] == 'B'
            && stack[stack.len() - 1] == 'C'
        {
            stack.pop();
            stack.pop();
            stack.pop();
        }
    }

    println!("{}", stack.iter().collect::<String>());
}
