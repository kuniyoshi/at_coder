use std::io::{self, BufRead};

fn main() {
    let (s, _t) = read().unwrap();

    println!("{} san", s);
}

fn read() -> io::Result<(String, String)> {
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();

    if let Some(Ok(input)) = lines.next() {
        let words: Vec<String> = input.split_whitespace().map(String::from).collect();

        if words.len() >= 2 {
            return Ok((words[0].clone(), words[1].clone()));
        }
    }

    Err(io::Error::new(io::ErrorKind::InvalidInput, "Insufficient input"))
}
