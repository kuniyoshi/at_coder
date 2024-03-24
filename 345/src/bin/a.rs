use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();
    match t(&s) {
        true => println!("Yes"),
        _ => println!("No"),
    }
}

fn t1(s: &Vec<char>) -> bool {
    s.len() > 0 && s[0] == '<'
}
fn t2(s: &Vec<char>) -> bool {
    if s.len() < 3 {
        return false;
    }

    for i in 1..(s.len()-1) {
        if s[i] != '=' {
            return false;
        }
    }

    true
}
fn t3(s: &Vec<char>) -> bool {
    s.last().map_or(false, |c| c == &'>')
}


fn t(s: &Vec<char>) -> bool {
    t1(s) && t2(s) && t3(s)
}
