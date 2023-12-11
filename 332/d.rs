use fmt::Debug;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (h, w): (usize, usize) = read_two(&mut lines);
    let a: Vec<Vec<usize>> = (0..h).map(|_| read_list(&mut lines)).collect();
    let b: Vec<Vec<usize>> = (0..h).map(|_| read_list(&mut lines)).collect();

    let mut row_indexes: Vec<usize> = Vec::new();
    let mut col_indexes: Vec<usize> = Vec::new();

    let min = dfs(&mut row_indexes, &mut col_indexes, &a, &b);

    match min {
        Some(ok) => println!("{}", ok),
        None => println!("{}", -1),
    };
}

fn test(
    row_indexes: &Vec<usize>,
    col_indexes: &Vec<usize>,
    a: &Vec<Vec<usize>>,
    b: &Vec<Vec<usize>>,
) -> bool {
    let mut c: Vec<Vec<usize>> = vec![vec![0; a[0].len()]; a.len()];

    for i in 0..c.len() {
        for j in 0..c[0].len() {
            c[i][j] = a[row_indexes[i]][col_indexes[j]];
        }
    }

    for i in 0..c.len() {
        for j in 0..c[0].len() {
            if c[i][j] != b[i][j] {
                return false;
            }
        }
    }

    true
}

fn swap_count_impl(indexes: &mut Vec<usize>) -> usize {
    let mut count: usize = 0;

    for i in 0..indexes.len() {
        let mut index: Option<usize> = None;

        for j in 0..indexes.len() {
            if indexes[j] == i {
                index = Some(j);
                break;
            }
        }

        match index {
            Some(index_value) => {
                for j in (0..index).rev() {
                    (indexes[j], indexes[j + 1]) = (indexes[j + 1], indexes[j]);
                }
            }
            None => continue,
        };
    }

    count
}

fn swap_count(row_indexes: &Vec<usize>, col_indexes: &Vec<usize>) -> usize {
    swap_count_impl(row_indexes.clone()) + swap_count_impl(col_indexes.clone())
}

fn dfs(
    row_indexes: &mut Vec<usize>,
    col_indexes: &mut Vec<usize>,
    a: &Vec<Vec<usize>>,
    b: &Vec<Vec<usize>>,
) -> Option<usize> {
    let i_count = row_indexes.len();
    let j_count = col_indexes.len();

    if i_count == a.len() && j_count == a[0].len() {
        if test(row_indexes, col_indexes, a, b) {
            return Some(swap_count(row_indexes, col_indexes));
        } else {
            return None;
        }
    }

    let mut min: Option<usize> = None;

    for i in i_count..a.len() {
        row_indexes.push(i);
        for j in j_count..a[0].len() {
            col_indexes.push(j);
            match dfs(row_indexes.clone(), col_indexes.clone(), a, b) {
                Some(c) => min = min.map_or(Some(c)).min(Some(c)),
                None => (),
            };
            col_indexes.pop();
        }
        row_indexes.pop();
    }

    min
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
