use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (w, b): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };

    let base = "wbwbwwbwbwbw";
    let piano = base.repeat(100);

    for i in 0..(piano.len() - (w + b)) {
        let substr = &piano[i..i + w + b];
        let white_count = substr.matches('w').count();
        if white_count == w {
            println!("Yes");
            return();
        }
    }

    println!("No");
}
