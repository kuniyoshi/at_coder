use fmt::Debug;
use std::collections::VecDeque;
use std::fmt;
use std::io::{self, BufRead};
use std::str;

fn main() {
    let mut lines = io::stdin().lock().lines();
    let n: usize = read_one(&mut lines);
    let r: Vec<char> = read_one::<String>(&mut lines).chars().collect();
    let c: Vec<char> = read_one::<String>(&mut lines).chars().collect();

    let mut remains: VecDeque<char> = vec!['A', 'B', 'C'].into();
    let mut rows: Vec<Vec<char>> = vec![vec!('.'; n); n];
    let is_found = dfs(&mut remains, &mut rows, &r, &c);

    if is_found {
        println!("{}", yes_no(true));
        rows.iter()
            .for_each(|cols| println!("{}", cols.iter().collect::<String>()));
    } else {
        println!("{}", yes_no(false));
    }
}

fn test2(sets: &Vec<Vec<char>>, constraints: &Vec<char>) -> bool {
    assert!(sets.len() == constraints.len());

    for i in 0..sets.len() {
        let candidate = sets[i].iter().find(|&&c| c != '.');
        match candidate {
            Some(&ch) if ch == constraints[i] => continue,
            _ => return false,
        }
    }

    true
}

fn test(rows: &Vec<Vec<char>>, r: &Vec<char>, c: &Vec<char>) -> bool {
    assert!(rows.len() == r.len());
    let cols: Vec<_> = (0..rows.len())
        .map(|i| rows.iter().map(|cols| cols[i]).collect::<Vec<_>>())
        .collect();

    test2(rows, r) && test2(&cols, c)
}

fn dfs(
    remains: &mut VecDeque<char>,
    rows: &mut Vec<Vec<char>>,
    r: &Vec<char>,
    c: &Vec<char>,
) -> bool {
    let code = match remains.pop_front() {
        Some(code) => code,
        None => return test(rows, r, c),
    };

    let mut permutations: Vec<usize> = (0..r.len()).collect();

    'outer: loop {
        for i in 0..permutations.len() {
            if rows[i][permutations[i]] != '.' {
                if !permutations.next_permutation() {
                    break 'outer;
                }
                continue 'outer;
            }
        }

        for i in 0..permutations.len() {
            rows[i][permutations[i]] = code;
        }

        let result = dfs(remains, rows, r, c);

        if result {
            return true;
        }

        for i in 0..permutations.len() {
            // assert!(rows[i][permutations[i]] == code, "{} == {}", rows[i][permutations[i]], code);
            assert!(
                rows[i][permutations[i]] == code,
                "Mismatch at index {}. \nchar: {}\nrows: {:?} \npermutations: {:?}",
                i,
                code,
                rows,
                permutations
            );

            rows[i][permutations[i]] = '.';
        }

        if !permutations.next_permutation() {
            break;
        }
    }

    remains.push_back(code);

    false
}

fn yes_no(is_yes: bool) -> String {
    if is_yes {
        "Yes".to_string()
    } else {
        "No".to_string()
    }
}

fn read_one<A: str::FromStr>(lines: &mut io::Lines<io::StdinLock>) -> A
where
    A::Err: Debug + 'static,
{
    lines.next().unwrap().unwrap().parse().unwrap()
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
