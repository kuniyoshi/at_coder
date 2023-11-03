use fmt::Debug;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = read_one(&mut lines);
    let r: Vec<_> = lines.next().unwrap().unwrap().chars().collect();
    let c: Vec<_> = lines.next().unwrap().unwrap().chars().collect();

    let mut result = Vec::new();
    let found = recursive(&r, &c, n, &mut result);

    if found {
        println!("{}", yes_no(true));
        for i in 0..result.len() {
            println!("{}", result[i].iter().collect::<String>());
        }
    }
    else {
        println!("{}", yes_no(false));
    }

    // loop {
    //     eprintln!("{:?}", r);
    //     if !r.next_permutation() {
    //         break;
    //     }
    // }
}

fn test(rows: &Vec<Vec<char>>, r: &Vec<char>, c: &Vec<char>) -> bool {
    // eprintln!("{:?}", "-".repeat(80));
    // for i in 0..rows.len() {
    //     eprintln!("{:?}", rows[i].iter().collect::<String>());
    // }
    let n = rows.len();
    for i in 0..n {
        for j in 0..n {
            if rows[i][j] == '.' {
                continue;
            }
            if rows[i][j] != r[i] {
                // eprintln!("r -> ({}, {}), {} != {}", i, j, rows[i][j], r[i]);
                return false;
            }
            break;
        }

        for j in 0..n {
            if rows[j][i] == '.' {
                continue;
            }
            if rows[j][i] != c[i] {
                // eprintln!("c -> ({}, {}), {} != {}", i, j, rows[j][i], c[i]);
                return false;
            }
            break;
        }
    }
    true
}

fn recursive(r: &Vec<char>, c: &Vec<char>, n: usize, rows: &mut Vec<Vec<char>>) -> bool {
    if rows.len() == n {
        return test(rows, r, c);
    }

    let mut abc: Vec<_> = "ABC".chars().collect();

    loop {
        if abc[0] == r[rows.len()] {
            break;
        }

        if !abc.next_permutation() {
            panic!("Could not find permutation any more.");
        }
    }

    let mut cols = abc;
    cols.splice(0..0, vec!('.'; n - 3));

    rows.push(cols);
    let index = rows.len() - 1;

    loop {
        if !test_row(&rows[index], r[index]) {
            break;
        }

        let result = recursive(r, c, n, rows);

        if result {
            return true;
        }

        if !rows[index].next_permutation() {
            break;
        }
    }

    rows.pop();
    false
}

fn test_row(cols: &Vec<char>, first: char) -> bool {
    for i in 0..cols.len() {
        if cols[i] == '.' {
            continue;
        }
        return cols[i] == first;
    }
    panic!("Could not test permutation.");
}

fn read_one<T: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> T
where
    T::Err: Debug + 'static,
{
    lines.next().unwrap().unwrap().parse().unwrap()
}

fn yes_no(is_yes: bool) -> String {
    if is_yes {
        "Yes".to_string()
    } else {
        "No".to_string()
    }
}

trait Permutation {
    fn next_permutation(&mut self) -> bool;
}

impl<T: Ord> Permutation for Vec<T> {
    fn next_permutation(&mut self) -> bool {
        if self.len() <= 1 {
            return false;
        }

        let mut i = self.len() - 1;
        while i > 0 && self[i - 1] >= self[i] {
            i -= 1;
        }

        if i == 0 {
            return false;
        }

        let mut j = self.len() - 1;
        while j >= i && self[j] <= self[i - 1] {
            j -= 1;
        }

        self.swap(i - 1, j);

        self[i..].reverse();

        true
    }
}
