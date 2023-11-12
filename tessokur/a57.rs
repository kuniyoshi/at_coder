use fmt::Debug;
use std::collections::HashMap;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

// これ (1 -> 2 -> 3 -> 4 -> 5 -> 3) みたいに平路に髭があると誤答する
fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, q): (usize, usize) = read_two(&mut lines);
    // 1 2 3 4 5 6 7
    // 2 4 1 7 6 5 3
    // 1 -> 2 -> 4 -> 7 -> 3 -> 1
    // 5 -> 6 -> 5
    let a: Vec<usize> = read_list(&mut lines).iter().map(|v| v - 1_usize).collect();

    let mut maps: HashMap<usize, usize> = HashMap::new();
    let mut chains: Vec<Vec<usize>> = Vec::new();

    for i in 0..n {
        if maps.contains_key(&i) {
            continue;
        }

        chains.push(Vec::new());

        let mut cursor = i;

        while !maps.contains_key(&cursor) {
            maps.insert(cursor, chains.len() - 1);
            chains.last_mut().unwrap().push(cursor);
            cursor = a[cursor];
        }
    }

    let mut pos: HashMap<usize, usize> = HashMap::new();

    for i in 0..chains.len() {
        let len = chains[i].len();
        for j in 0..len {
            pos.insert(chains[i][j], j);
        }
    }

    for i in 0..chains.len() {
        let len = chains[i].len();
        for j in 0..len {
            let v = chains[i][j];
            chains[i].push(v);
        }
    }

    for _ in 0..q {
        let (mut x, mut y): (usize, usize) = read_two(&mut lines);
        x -= 1;

        let index = maps.get(&x).unwrap();
        y %= chains[*index].len() / 2;

        println!("{}", chains[*index][pos.get(&x).unwrap() + y] + 1);
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
