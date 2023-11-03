use fmt::Debug;
use std::fmt;
use std::io::{self, BufRead};
use std::str;
use std::collections::HashMap;

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
    } else {
        println!("{}", yes_no(false));
    }
}

fn is_answer(rows: &Vec<Vec<char>>) -> bool {
    return false;
    // let answer: Vec<Vec<char>> = vec![
    //     "AC..B".chars().collect(),
    //     ".BA.C".chars().collect(),
    //     "C.BA.".chars().collect(),
    //     "BA.C.".chars().collect(),
    //     "..CBA".chars().collect(),
    // ];
    let answer: Vec<Vec<char>> = vec![
        "ABC".chars().collect(),
        "BAC".chars().collect(),
        "CAB".chars().collect(),
    ];

    rows.iter()
        .zip(answer.iter())
        .all(|(row, target)| row == target)
}

fn test(rows: &Vec<Vec<char>>, r: &Vec<char>, c: &Vec<char>) -> bool {
    let is_answer = is_answer(rows);

    if is_answer {
        eprintln!("{:?}", "-".repeat(80));
        for i in 0..rows.len() {
            eprintln!("{:?}", rows[i].iter().collect::<String>());
        }
    }

    for i in 0..rows.len() {
        if !test_row(&rows[i], r[i]) {
            return false;
        }
        if !test_row(&rows.iter().map(|row| row[i]).collect::<Vec<char>>(), c[i]) {
            return false;
        }
    }

    let cols: Vec<Vec<char>> = (0..rows[0].len()).map(|i| rows.iter().map(|row| row[i]).collect()).collect();

    cols.iter().all(|chars| {
        let mut count = HashMap::new();
        for ch in chars.iter() {
            *count.entry(*ch).or_insert(0) += 1;
        }
        count.remove(&'.');
        count.len() == 3 && count.values().all(|&c| c == 1)
    })
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
    cols.splice(0..0, vec!['.'; n - 3]);

    rows.push(cols);
    let index = rows.len() - 1;

    loop {
        if !test_row(&rows[index], r[index]) {
            if !rows[index].next_permutation() {
                break;
            }
            continue;
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
    match cols.iter().find(|&&ch| ch != '.') {
        Some(&ch) => ch == first,
        None => false,
    }
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
