use fmt::Debug;
use std::collections::{HashMap, VecDeque};
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, m): (usize, usize) = read_two(&mut lines);
    let a: Vec<usize> = read_list(&mut lines).iter().map(|v| v - 1_usize).collect();
    let b: Vec<usize> = read_list(&mut lines).iter().map(|v| v - 1_usize).collect();

    let mut links: Vec<Vec<usize>> = vec!(Vec::new(); n);
    let mut color: HashMap<usize, bool> = HashMap::new();

    for i in 0..m {
        links[a[i]].push(b[i]);
        links[b[i]].push(a[i]);
    }

    // eprintln!("{:?}", links);

    let mut queue: VecDeque<(usize, bool)> = VecDeque::new();

    for i in 0..n {
        if color.contains_key(&i) {
            continue;
        }

        queue.push_back((i, true));

        while queue.len() > 0 {
            let t = queue.pop_front().unwrap();

            color.insert(t.0, t.1);

            for j in 0..links[t.0].len() {
                if let Some(c) = color.get(&links[t.0][j]) {
                    if *c == t.1 {
                        println!("{}", yes_no(false));
                        return;
                    }
                }

                if !color.contains_key(&links[t.0][j]) {
                    queue.push_back((links[t.0][j], !t.1));
                }
            }
        }
    }

    println!("{}", yes_no(true));
}

fn yes_no(is_yes: bool) -> &'static str {
    if is_yes { "Yes" } else { "No" }
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
