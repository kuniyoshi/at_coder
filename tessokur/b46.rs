use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let parenthesises: Vec<char> = lines.next().unwrap().unwrap().chars().collect();

    let mut stack: Vec<(usize, char)> = Vec::new();
    let mut pairs: Vec<(usize, usize)> = Vec::new();

    for i in 0..parenthesises.len() {
        if parenthesises[i] == ')' {
            assert!(stack[stack.len() - 1].1 == '(');
            pairs.push((stack[stack.len() - 1].0, i));
            stack.pop();
            continue;
        }
        stack.push((i, parenthesises[i]));
    }

    // pairs.reverse();

    for pair in pairs {
        println!("{} {}", pair.0 + 1, pair.1 + 1);
    }
}
