use std::collections::HashMap;
use std::io::{self, BufRead};

static UNIT: usize = 1_000_000_007;

struct P {
    n: usize,
    w: usize,
    l: usize,
    r: usize,
    x: Vec<usize>,
}

fn main() {
    let mut lines = io::stdin().lock().lines();
    let (n, w, l, r): (usize, usize, usize, usize) = {
        let list: Vec<usize> = lines
            .next()
            .unwrap()
            .unwrap()
            .split_whitespace()
            .map(|s| s.parse().unwrap())
            .collect();
        (list[0], list[1], list[2], list[3])
    };
    let mut x: Vec<usize> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();

    x.push(w);
    x.insert(0, 0);

    let p: P = P { n, w, l, r, x };
    let mut cache: HashMap<usize, usize> = HashMap::new();

    println!("{}", recursive(p.x.len() - 1, &mut cache, &p));
    eprintln!("{:?}", p.x);
    eprintln!("{:?}", cache);
}

fn lower_bound(from: usize, p: &P) -> Option<usize> {
    if p.x[from] + p.l > *p.x.last().unwrap() {
        return None;
    }
    if p.x[from] + p.l == *p.x.last().unwrap() {
        return Some(p.x.len() - 1);
    }

    let mut ac = p.x.len() - 1;
    let mut wa = from;

    while ac - wa > 1 {
        let wj = (ac + wa) / 2;
        if p.x[wj] >= p.x[from] + p.l {
            ac = wj;
        } else {
            wa = wj;
        }
    }

    Some(ac)
}

fn upper_bound(from: usize, p: &P) -> Option<usize> {
    if p.x[from] + p.r > *p.x.last().unwrap() {
        return None;
    }
    if p.x[from] + p.r == *p.x.last().unwrap() {
        return Some(p.x.len() - 1);
    }

    let mut ac = from;
    let mut wa = p.x.len() - 1;

    while wa - ac > 1 {
        let wj = (ac + wa) / 2;
        if p.x[wj] <= p.x[from] + p.r {
            ac = wj;
        } else {
            wa = wj;
        }
    }

    Some(ac)
}

fn recursive(index: usize, cache: &mut HashMap<usize, usize>, p: &P) -> usize {
    if let Some(&value) = cache.get(&index) {
        return value;
    }

    let lower = lower_bound(index, p);
    let upper = upper_bound(index, p);

    match (lower, upper) {
        (Some(lower_value), Some(upper_value)) if lower_value <= upper_value => {
            let mut total: usize = 0;

            for i in (lower_value..=upper_value).rev() {
                total += recursive(i, cache, p);
            }

            cache.insert(index, total);

            return total;
        }
        (Some(lower_value), None) => {
            let total = recursive(lower_value, cache, p);
            cache.insert(index, total);
            return total;
        }
        (None, Some(upper_value)) => {
            let total = recursive(upper_value, cache, p);
            cache.insert(index, total);
            return total;
        }
        _ => return 1,
    }
}
