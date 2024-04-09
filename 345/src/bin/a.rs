use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();

    let t = "<".to_owned() + &("=".repeat(s.len() - 2)) + ">";

    if s.iter().collect::<String>().eq(&t) {
        println!("Yes");
    } else {
        println!("No");
    }
}
