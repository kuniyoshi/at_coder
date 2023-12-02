use fmt::Debug;
use std::collections::HashMap;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, q): (usize, usize) = read_two(&mut lines);
    let cells: Vec<Vec<char>> = (0..n).map(|_| {
        lines.next().unwrap().unwrap().chars().collect()
    }).collect();
    let queries: Vec<(usize, usize, usize, usize)> = (0..q).map(|_| {
        read_four(&mut lines)
    }).collect();

    // eprintln!("{:?}", cells);
    // eprintln!("{:?}", queries);

    let mut cell_accs: Vec<Vec<usize>> = Vec::new();

    cell_accs.push(vec![0; n + 1]);

    for i in 0..n {
        let mut accs: Vec<usize> = vec![0; 1];

        for j in 0..n {
            let new_value: usize = accs.last().unwrap() + (if cells[i][j] == 'B' { 1 } else { 0 }) as usize;
            accs.push(new_value);
        }

        cell_accs.push(accs);
    }

    for j in 1..=n {
        for i in 1..=n {
            cell_accs[i][j] += cell_accs[i - 1][j];
        }
    }

    eprintln!("{:?}", cell_accs);

    for i in 0..q {
        let (a, b, c, d) = queries[i];

        let cd_value = blacks(&cell_accs, c + 1, d + 1, n);
        println!("cd: {}", cd_value);
        let ab_value = blacks(&cell_accs, a, b, n);
        println!("ab: {}", ab_value);
        let ad_value = blacks(&cell_accs, a, d + 1, n);
        println!("ad: {}", ad_value);
        let bc_value = blacks(&cell_accs, c + 1, b, n);
        println!("bc: {}", bc_value);

        println!("{}", cd_value + ab_value - ad_value - bc_value);
    }
}

fn blacks(accs: &Vec<Vec<usize>>, i: usize, j: usize, n: usize) -> usize {
    // println!("### blacks");
    let cd = ( i / n * j / n ) * accs.last().unwrap().last().unwrap();
    // println!("--- cd: {}", cd);
    let cdh =  ( i / n ) * accs.last().unwrap()[j % n];
    // println!("--- cdh: {}", cdh);
    let cdv = (j / n) * accs[i % n].last().unwrap();
    // println!("--- cdv: {}", cdv);
    let cdr = accs[i % n][j % n];
    // println!("--- cdr: {}", cdr);

    cd + cdh + cdv + cdr
}

fn yes_no(is_yes: bool) -> &'static str {
    if is_yes {
        "Yes"
    } else {
        "No"
    }
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

fn read_four<A: str::FromStr, B: str::FromStr, C: str::FromStr, D: str::FromStr>(
    lines: &mut io::Lines<io::StdinLock>,
) -> (A, B, C, D)
where
    A::Err: Debug + 'static,
    B::Err: Debug + 'static,
    C::Err: Debug + 'static,
    D::Err: Debug + 'static,
{
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: A = parts.next().unwrap().parse().unwrap();
    let b: B = parts.next().unwrap().parse().unwrap();
    let c: C = parts.next().unwrap().parse().unwrap();
    let d: D = parts.next().unwrap().parse().unwrap();
    (a, b, c, d)
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

fn read_one<A: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> A
where
    A::Err: Debug + 'static,
{
    lines.next().unwrap().unwrap().parse().unwrap()
}
