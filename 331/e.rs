use fmt::Debug;
use std::collections::HashSet;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, m, l): (usize, usize, usize) = read_three(&mut lines);
    let a: Vec<usize> = read_list(&mut lines);
    let b: Vec<usize> = read_list(&mut lines);

    let mut a_indexes: Vec<(usize, usize)> = a.iter().enumerate().map(|(i, &v)| (i, v)).collect();
    a_indexes.sort_by(|a, b| b.1.cmp(&a.1));
    let mut b_indexes: Vec<(usize, usize)> = b.iter().enumerate().map(|(i, &v)| (i, v)).collect();
    b_indexes.sort_by(|a, b| b.1.cmp(&a.1));
    // eprintln!("{:?}", a_indexes);
    // eprintln!("{:?}", b_indexes);

    let cds: Vec<(usize, usize)> = (0..l).map(|_| read_two(&mut lines)).collect();

    let mut disabled: HashSet<(usize, usize)> = HashSet::new();

    for &(c, d) in &cds {
        disabled.insert((c - 1, d - 1));
    }

    // eprintln!("{:?}", disabled);

    let mut max: usize = 0;

    'LOOP:
    for i in 0..n {
        let mut bi: usize = 0;

        while disabled.contains(&(a_indexes[i].0, b_indexes[bi].0)) {
            bi += 1;
            if bi == m {
                continue 'LOOP;
            }
        }

        max = max.max(a[a_indexes[i].0] + b[b_indexes[bi].0]);
    }

    println!("{}", max);
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

fn read_three<A: str::FromStr, B: str::FromStr, C: str::FromStr>(
    lines: &mut io::Lines<io::StdinLock>,
) -> (A, B, C)
where
    A::Err: Debug + 'static,
    B::Err: Debug + 'static,
    C::Err: Debug + 'static,
{
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: A = parts.next().unwrap().parse().unwrap();
    let b: B = parts.next().unwrap().parse().unwrap();
    let c: C = parts.next().unwrap().parse().unwrap();
    (a, b, c)
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
