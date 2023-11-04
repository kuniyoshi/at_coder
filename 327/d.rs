use fmt::Debug;
use std::collections::VecDeque;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, m): (usize, usize) = read_two(&mut lines);
    let a: Vec<usize> = read_list(&mut lines).iter().map(|v| v - 1usize).collect();
    let b: Vec<usize> = read_list(&mut lines).iter().map(|v| v - 1usize).collect();

    let mut invert_a: Vec<Vec<usize>> = vec![Vec::new(); n];
    let mut invert_b: Vec<Vec<usize>> = vec![Vec::new(); n];

    for i in 0..m {
        invert_a[a[i]].push(i);
        invert_b[b[i]].push(i);
    }

    println!("{}, {}", n, m);
    eprintln!("{:?}", a);
    eprintln!("{:?}", invert_a);
    eprintln!("{:?}", b);
    eprintln!("{:?}", invert_b);

    println!("{}", yes_no(test(&a, &b, invert_a, invert_b, n, m)));
}

fn yes_no(is_yes: bool) -> String {
    if is_yes {
        "Yes".to_string()
    } else {
        "No".to_string()
    }
}

fn test(
    a: &Vec<usize>,
    b: &Vec<usize>,
    invert_a: Vec<Vec<usize>>,
    invert_b: Vec<Vec<usize>>,
    n: usize,
    m: usize,
) -> bool {
    let mut x: Vec<Option<bool>> = vec![None; n];

    for i in 0..m {
        let mut queue: VecDeque<(bool, usize)> = VecDeque::new();

        match x[a[i]] {
            None => queue.push_back((true, a[i])),
            Some(_) => todo!(),
        };

        while queue.len() > 0 {
            match queue.pop_front().unwrap() {
                (true, ai) => {
                    match x[b[ai]] {
                        Some(ture) => return false,
                        Some(false) => todo!(),
                        None => x[b[ai]] = Some(false),
                    };

                    for j in 0..invert_b[b[ai]].len() {
                        queue.push_back((false, invert_b[b[ai]][j]));
                    }
                }
                (false, bi) => {
                    match x[a[bi]] {
                        Some(false) => return false,
                        Some(true) => todo!(),
                        None => x[a[bi]] = Some(true),
                    }

                    for j in 0..invert_a[a[bi]].len() {
                        queue.push_back((true, invert_a[a[bi]][j]));
                    }
                }
            };
        }
    }

    true
}

fn read_list<A: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> Vec<A>
where
    A::Err: Debug + 'static,
{
    let line = lines.next().unwrap().unwrap();
    line.split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect()
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
