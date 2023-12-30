use std::io::{self, BufRead};

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, k): (usize, usize) = {
        let list: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();
        (list[0], list[1])
    };
    let a: Vec<usize> = lines.next().unwrap().unwrap().split_whitespace().map(|s| s.parse().unwrap()).collect();

    let mut count: usize = 0;

    for i in 0..n {
        let min = lower_bound(if a[i] >= k { a[i] - k } else { a[i] }, &a);
        let max = upper_bound(a[i] + k, &a);

        match (min, max) {
            (Some(min_index), Some(max_index)) => count += max_index - min_index,
            _ => panic!("Could not find lower_bound, and upper_bound"),
        }
    }

    println!("{}", count / 2);
}

// value より小さいもののうち、最大の添字を返す
fn upper_bound(value: usize, a: &Vec<usize>) -> Option<usize> {
    if a.len() == 0 {
        return None;
    }

    if value < a[0] {
        return None;
    }

    if a.last().unwrap() <= &value {
        return Some(a.len() - 1);
    }

    let mut ac: usize = a.len() - 1;
    let mut wa: usize = 0;

    while ac - wa > 1 {
        let wj = (ac + wa) / 2;
        if a[wj] <= value {
            ac = wj;
        } else {
            wa = wj;
        }
    }

    Some(ac)
}

// value 以上であるもののうち、最小の添え字を返す
fn lower_bound(value: usize, a: &Vec<usize>) -> Option<usize> {
    if a.len() == 0 {
        return None;
    }

    if &value > a.last().unwrap() {
        return None;
    }

    if a[0] >= value {
        return Some(0);
    }

    let mut ac: usize = a.len() - 1;
    let mut wa: usize = 0;

    while ac - wa > 1 {
        let wj = (ac + wa) / 2;
        if a[wj] >= value {
            ac = wj;
        }
        else {
            wa = wj;
        }
    }

    Some(ac)
}