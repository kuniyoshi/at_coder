use std::io::{self, BufRead};
use std::collections::VecDeque;
use std::cmp;

fn main() {
    let stdin = io::stdin().lock();
    let mut lines = stdin.lines();
    let input = lines.next().unwrap().unwrap();
    let mut iter = input.trim().split_whitespace();
    let n: usize = iter.next().unwrap().parse().unwrap();
    let r: Vec<char> = lines.next().unwrap().unwrap().chars().collect();
    let c: Vec<char> = lines.next().unwrap().unwrap().chars().collect();

    let mut abc = "ABC".to_string();
    while abc.len() < n {
        abc.push('.');
    }
    let mut rows = vec![VecDeque::new(); 3];
    let mut chars: Vec<_> = abc.chars().collect();
    chars.sort();

    loop {
        if let Some(&first_non_dot) = chars.iter().find(|&&ch| ch != '.') {
            rows[first_non_dot as usize - 'A' as usize].push_back(chars.clone());
        }

        if !chars.next_permutation() {
            break;
        }
    }

    let mut grid = Vec::new();
    let mut fnd = false;
    let depth = dfs(0, (1 << (4 * n)) - 1, &rows, &r, &c, &mut grid, &mut fnd, 0);
    eprintln!("{:?}", depth);

    if fnd {
        println!("Yes");
        for row in &grid {
            for ch in row {
                print!("{}", ch);
            }
            println!();
        }
    } else {
        println!("No");
    }
}

fn dfs(i: usize, fl: usize, rows: &Vec<VecDeque<Vec<char>>>, r: &Vec<char>, c: &Vec<char>, grid: &mut Vec<Vec<char>>, fnd: &mut bool, depth: usize) -> usize{
    if *fnd {
        return depth;
    }

    if i == r.len() {
        if fl == 0 {
            *fnd = true;
        }
        return depth;
    }

    let mut max = depth;

    for nx in &rows[r[i] as usize - 'A' as usize] {
        grid.push(nx.clone());

        let mut ufl = fl;
        let mut und = true;

        for j in 0..r.len() {
            if nx[j] == '.' {
                continue;
            }
            let kind = nx[j] as usize - 'A' as usize;

            if (fl & (1 << (4 * j + kind))) == 0 {
                und = false;
                break;
            }

            ufl ^= 1 << (4 * j + kind);
            if (fl & (1 << (4 * j + 3))) != 0 {
                if nx[j] != c[j] {
                    und = false;
                    break;
                }
                ufl ^= 1 << (4 * j + 3);
            }
        }

        if und {
            let d = dfs(i + 1, ufl, rows, r, c, grid, fnd, depth + 1);
            max = cmp::max(max, d);
        }

        grid.pop();
    }

    max
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
