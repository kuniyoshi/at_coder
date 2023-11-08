use fmt::Debug;
use std::collections::{HashSet, VecDeque};
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, m): (usize, usize) = read_two(&mut lines);
    let a: Vec<usize> = read_list(&mut lines).iter().map(|v| v - 1usize).collect();
    let b: Vec<usize> = read_list(&mut lines).iter().map(|v| v - 1usize).collect();

    println!("{}", yes_no(test(&a, &b, n, m)));
}

fn yes_no(is_yes: bool) -> String {
    if is_yes {
        "Yes".to_string()
    } else {
        "No".to_string()
    }
}

fn test(a: &Vec<usize>, b: &Vec<usize>, n: usize, m: usize) -> bool {
    let mut link: Vec<Vec<usize>> = (0..2 * m).map(|_| Vec::new()).collect();

    for i in 0..m {
        link[i].push(b[i]);
        link[m + i].push(m + a[i]);
    }

    let mut visited: HashSet<usize> = HashSet::new();
    let mut queue: VecDeque<usize> = VecDeque::new();

    for i in 0..(2 * m) {
        if visited.contains(&i) {
            continue;
        }

        queue.push_back(i);

        while queue.len() > 0 {
            let item = queue.pop_front().unwrap();
        }

        visited.insert(i);
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
