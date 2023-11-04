use fmt::Debug;
use std::collections::HashSet;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let a: Vec<Vec<usize>> = (0..9).map(|_| read_list(&mut lines)).collect();

    println!("{}", yes_no(test(&a)));
}

fn test(a: &Vec<Vec<usize>>) -> bool {
    let row_col = a.iter().all(|b| test2(&b))
        && (0..9)
            .map(|i| a.iter().map(|cols| cols[i]).collect())
            .all(|b| test2(&b));

    if !row_col {
        return false;
    }

    let mut sets: Vec<Vec<usize>> = vec!(Vec::new(); 9);

    for i in 0..9 {
        for j in 0..9 {
            sets[3 * row(i) + col(j)].push(a[i][j]);
        }
    }

    sets.iter().all(|set| test2(&set))
}

fn col(c: usize) -> usize {
    c / 3
}

fn row(r: usize) -> usize {
    r / 3
}

fn test2(a: &Vec<usize>) -> bool {
    let mut set: HashSet<usize> = HashSet::new();

    for i in 0..a.len() {
        set.insert(a[i]);
    }

    set.len() == 9
}

fn yes_no(is_yes: bool) -> String {
    if is_yes {
        "Yes".to_string()
    } else {
        "No".to_string()
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
