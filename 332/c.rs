use fmt::Debug;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, m): (usize, usize) = read_two(&mut lines);
    let s: Vec<char> = lines.next().unwrap().unwrap().chars().collect();

    'LOOP:
    for logo in 0..=n {
        let mut used_void: usize = 0;
        let mut used_logo: usize = 0;

        for i in 0..s.len() {
            if s[i] == '0' {
                used_void = 0;
                used_logo = 0;
            } else if s[i] == '1' {
                if used_void == m {
                    used_logo += 1;
                } else {
                    used_void += 1;
                }

                if used_void > m {
                    continue 'LOOP;
                }
                if used_logo > logo {
                    continue 'LOOP;
                }
            } else if s[i] == '2' {
                used_logo += 1;

                if used_logo > logo {
                    continue 'LOOP;
                }
            }
            else {
                panic!("Unknown schedule: {}", s[i]);
            }
        }

        println!("{}", logo);
        return;
    }
}

fn read_two<A: str::FromStr, B: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> (A, B)
where
    A::Err: Debug + 'static,
    B::Err: Debug + 'static,
{
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: A = parts.next().unwrap().parse().unwrap();
    let b: B = parts.next().unwrap().parse().unwrap();
    (a, b)
}
