use std::io::{self, BufRead};

struct P {
    unused_zero: Option<usize>,
    unused_one: Option<usize>,
    used_zero: Option<usize>,
    used_one: Option<usize>,
}

impl P {
    fn new(value: char, cost: usize) -> P {
        if value == '0' {
            P {
                unused_zero: Some(0),
                unused_one: Some(cost),
                used_zero: None,
                used_one: None,
            }
        } else {
            P {
                unused_zero: Some(cost),
                unused_one: Some(0),
                used_zero: None,
                used_one: None,
            }
        }
    }

    fn next(self, value: char, cost: usize) -> P {
        if value == '0' {
            P {
                unused_zero: self.unused_one,
                unused_one: Self::add(self.unused_zero, cost),
                used_zero: Self::select(self.unused_zero, self.used_one),
                used_one: Self::select(Self::add(self.used_zero, cost), Self::add(self.unused_one, cost)),
            }
        } else {
            P {
                unused_zero: Self::add(self.unused_one, cost),
                unused_one: self.unused_zero,
                used_zero: Self::select(Self::add(self.used_one, cost), Self::add(self.unused_zero, cost)),
                used_one: Self::select(self.unused_one, self.used_zero),
            }
        }
    }

    fn result(self: &Self) -> usize {
        Self::select(self.used_zero, self.used_one).unwrap()
    }

    fn add(a: Option<usize>, cost: usize) -> Option<usize> {
        match a {
            Some(a_value) => Some(a_value + cost),
            None => None,
        }
    }

    fn select(a: Option<usize>, b: Option<usize>) -> Option<usize> {
        match (a, b) {
            (Some(a_value), Some(b_value)) => Some(a_value.min(b_value)),
            (Some(_), None) => a,
            _ => b,
        }
    }
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = lines.next().unwrap().unwrap().parse().unwrap();
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();
    let c: Vec<usize> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();

    let mut p = P::new(s[0], c[0]);

    // 00011
    for i in 1..n {
        p = p.next(s[i], c[i]);
    }

    println!("{}", p.result());
}
