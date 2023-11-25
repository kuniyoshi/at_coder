use fmt::Debug;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = read_one(&mut lines);
    let s: Vec<Vec<char>> = (0..n)
        .map(|_| lines.next().unwrap().unwrap().chars().collect())
        .collect();
    // eprintln!("{:?}", s);

    let mut counts_by_col: Vec<usize> = vec![0; n];
    let mut counts_by_row: Vec<usize> = vec![0; n];

    for i in 0..n {
        for j in 0..n {
            if s[i][j] == 'o' {
                counts_by_col[j] += 1;
                counts_by_row[i] += 1;
            }
        }
    }

    eprintln!("{:?}", counts_by_col);
    eprintln!("{:?}", counts_by_row);

    let mut total: usize = 0;

    for i in 0..n {
        let mut count: usize = 0;
        if counts_by_row[i] < 2 {
            continue;
        }

        for j in 0..n {
            if s[i][j] == 'o' {
                count += counts_by_col[j] - 1;
            }
        }

        total += count * (counts_by_row[i] - 1);
    }

    println!("{}", total);
}

fn read_one<A: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> A
where
    A::Err: Debug + 'static,
{
    lines.next().unwrap().unwrap().parse().unwrap()
}
