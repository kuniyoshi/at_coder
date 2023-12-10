use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let a: Vec<usize> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();

    let mut stack: Vec<(usize, usize)> = Vec::new();
    let mut results: Vec<Option<usize>> = Vec::new();

    for i in 0..n {
        let mut result: Option<usize> = None;

        while let Some((value, _)) = stack.last() {
            if value < &a[i] {
                stack.pop();
            } else {
                break;
            }
        }

        // len = 3
        // 0, 1, 2
        // 2, 1, 0
        // 3 - 2, 3 - 1, 3 - 0
        for j in (0..stack.len()).rev() {
            if stack[j].0 > a[i] {
                result = Some(stack[j].1);
                break;
            }
        }

        results.push(result);
        stack.push((a[i], i + 1));
    }

    for i in 0..results.len() {
        match results[i] {
            Some(value) => println!("{}", value),
            None => println!("{}", -1),
        }
    }
}
