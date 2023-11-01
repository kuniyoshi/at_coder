use std::io::{self};
use std::cmp;

fn main() {
    let mut lines = io::stdin().lines();
    let (_, m) = read_two(&mut lines);
    let mut a = read_list(&mut lines);
    a.sort();

    let mut max = 0;

    for i in 0..a.len() {
        if a[a.len() - 1] < a[i] + m {
            max = cmp::max(max, a.len() - i);
            break;
        }

        let mut ac = i;
        let mut wa = a.len() - 1;

        while wa - ac > 1 {
            let wj = (ac + wa) / 2;

            if a[wj] < a[i] + m {
                ac = wj;
            }
            else {
                wa = wj;
            }

            max = cmp::max(max, ac - i);
        }
    }

    println!("{}", max + 1);
}

fn read_list(lines: &mut io::Lines<io::StdinLock>) -> Vec<usize> {
    let line = lines.next().unwrap().unwrap();
    line.split_whitespace().map(|s| s.parse().unwrap()).collect()
}

fn read_two(lines: &mut io::Lines<io::StdinLock>) -> (usize, usize) {
    let line = lines.next().unwrap().unwrap();
    let mut parts = line.split_whitespace();
    let a: usize = parts.next().unwrap().parse().unwrap();
    let b: usize = parts.next().unwrap().parse().unwrap();
    (a, b)
}
