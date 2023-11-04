use fmt::Debug;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let _: usize = read_one(&mut lines);
    let chars: Vec<char> = read_one::<String>(&mut lines).chars().collect();
    println!("{}", yes_no(test(&chars)));
}

fn test(chars: &Vec<char>) -> bool {
    let mut previous: char = '.';

    for i in 0..chars.len() {
        if previous == 'a' && chars[i] == 'b' {
            return true;
        } else if previous == 'b' && chars[i] == 'a' {
            return true;
        }

        previous = chars[i];
    }

    return false;
}

fn yes_no(is_yes: bool) -> String {
    if is_yes {
        "Yes".to_string()
    } else {
        "No".to_string()
    }
}

fn read_one<A: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> A
where
    A::Err: Debug + 'static,
{
    lines.next().unwrap().unwrap().parse().unwrap()
}
