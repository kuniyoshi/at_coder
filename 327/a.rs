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
    chars
        .windows(2)
        .any(|window| window == ['a', 'b'] || window == ['b', 'a'])
}

fn yes_no(is_yes: bool) -> &'static str {
    if is_yes {
        "Yes"
    } else {
        "No"
    }
}

fn read_one<A: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> A
where
    A::Err: Debug + 'static,
{
    lines.next().unwrap().unwrap().parse().unwrap()
}
